#!/usr/bin/env bash

########################
# include the master
########################
. demo-master.sh
DEMO_PROMPT="${GREEN}anurags-MBP-2:os-demos anuragsaran$  ${BLACK}"
clear


echo "# Login to box https://10.1.2.2:8443/console"
# echo "# oc login https://10.1.2.2:8443/"
pe "cd /root/os-demo"
echo " delete old project"
pe "oc delete project a-demo-dev-env"
pe "oc version"
echo "# Get nodes info"
pe "oc get nodes"
echo "# Lets create project and run a run a pod now."
pe "oc new-project a-demo-dev-env --display-name=\"A Demo Dev Environment\""
echo "# Quota that controls object counts"
pe "cat ./configs/object-counts.yaml"
echo " "
pe "oc create -f ./configs/object-counts.yaml --namespace=a-demo-dev-env"
echo "# describe the quota to see what is currently being consumed"
pe "oc describe quota object-counts --namespace=a-demo-dev-env"
echo " cat ./configs/compute-resources.yaml "
echo " "
pe "oc create -f ./configs/compute-resources.yaml --namespace=a-demo-dev-env"
echo "# see what is currently being consumed"
pe "oc describe quota compute-resources --namespace=a-demo-dev-env"
echo "# Limits=Doorman. Assings default/Min/Max/overcommit-ratio."
pe "cat ./configs/limits-range.yaml"
echo " "
pe "oc create -f  ./configs/limits-range.yaml --namespace=a-demo-dev-env"
echo "Deploy demophpapp using the UI"
pe "for i in {1..20};do curl http://demophpapp-a-demo-dev-env.apps.anuragsdemo.com/; echo \"\"; done"
pe "oc annotate route/demophpapp haproxy.router.openshift.io/balance=roundrobin"
pe "for i in {1..20};do curl http://demophpapp-test-env.apps.anuragsdemo.com/; echo \"\"; done"
echo "Deploy the new version of the app and split the traffic"
pe "for i in {1..20};do curl http://demophpapp-a-demo-dev-env.apps.anuragsdemo.com/; echo \"\"; done"
echo "Split the traffic"
pe "for i in {1..20};do curl http://demophpapp-a-demo-dev-env.apps.anuragsdemo.com/; echo \"\"; done"
echo "Migrate the app now to test env"
pe "oc policy add-role-to-user edit system:serviceaccount:sharedservices:jenkins -n a-demo-dev-env"
pe "oc policy add-role-to-group system:image-puller system:serviceaccounts:test-env -n a-demo-dev-env"
pe "oc project test-env"
#pe "oc create deploymentconfig demophpapp --image=welcome-php -n test-env"
#pe "oc scale --replicas=0 dc demophpapp"
pe "oc annotate route/demophpapp haproxy.router.openshift.io/balance=roundrobin"
pe "for i in {1..20};do curl http://demophpapp-test-env.apps.anuragsdemo.com/; echo \"\"; done"
pe "oc get bc demophpapp -o json"
pe "oc get builds"
pe "oc logs build/demophpapp-1"
pe "oc get dc -o json"
pe "oc get pod"
pe "oc get services"
pe "oc get routes"
pe "oc scale --replicas=3 dc/demophpapp"
pe "oc describe service demophpapp"
pe "oc get pods"
pe "oc get rc/demophpapp-1"
pe "oc describe quota compute-resources --namespace=a-demo-dev-env"


