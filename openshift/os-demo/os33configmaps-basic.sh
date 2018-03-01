#!/usr/bin/env bash

########################
# include the master
########################
. demo-master.sh
DEMO_PROMPT="${GREEN}anurags-MBP-2:os-demos anuragsaran$  ${BLACK}"
clear

	
echo "# Login to box https://lb.anuragsdemo.com:8443/"
pe "oc new-project a-boademo"
pe "oc new-app https://github.com/anurag-saran/PrintEnv.git"
pe "oc expose svc printenv"
pe "oc get route printenv|awk '{print $2}'|grep printenv"
pe "curl $(oc get route printenv|awk '{print $2}'|grep printenv)|jq -S"
pe "oc set env dc/printenv APP_VAR_1=Value1 APP_VAR_2=Value2"
pe "oc env dc/printenv --list"
#pe "oc set env dc/printenv APP_VAR_2-"
pe "oc create configmap printenv-config \
    --from-literal=appvar3=Value3 \
    --from-literal=appvar4=Value4"
pe "oc edit configmap printenv-config"
p "*******> Update dc to read config map."
pe "oc edit dc printenv"
pe "oc env dc/printenv --list"
pe "curl $(oc get route printenv|awk '{print $2}'|grep printenv)|jq -S"
#echo "oc deploy printenv --latest"
pe "oc set env dc/printenv READ_FROM_FILE=/data/configfile.txt"
pe "echo 'This can be a xml file or a jason file or a key value file.' >configfile.txt"
pe "oc create configmap printenv-config-file --from-file=configfile.txt"
pe "oc set volume dc/printenv --add --overwrite --name=config-volume -m /data/ --source='{\"configMap\":{\"name\":\"printenv-config-file\",\"items\":[{\"key\":\"configfile.txt\",\"path\":\"configfile.txt\"}]}}'"
pe "curl $(oc get route printenv|awk '{print $2}'|grep printenv)"
p "********* Secrets ************"
pe "echo 'r3dh4t1!' > ./password.txt"
pe "echo 'admin' > ./user.txt"
pe "oc secret new printenv-secret appuser=user.txt apppassword=password.txt"
pe "oc describe secrets printenv-secret"
pe "oc edit  secrets printenv-secret"
pe "echo 'cjNkaDR0MSEK' | base64 --decode"
pe "echo 'YWRtaW4K' | base64 --decode"
pe "oc env dc/printenv --from=secret/printenv-secret"
pe "oc env dc/printenv --list"
pe "oc env dc/printenv --from=secret/printenv-secret --prefix=MYSQL_"
pe "oc env dc/printenv --list"
pe "echo 'r3dh4t1!' > ./dbpassword.txt"
pe "echo 'admin' > ./dbuser.txt"
pe "echo 'http://postgresql5432' > ./dburl.txt"
pe "oc secret new printenv-db-secret appdbuser=user.txt appdbpassword=password.txt appdburl=dburl.txt"
pe "oc set volume dc/printenv --add --overwrite --name=db-config-volume -m /dbconfig/ --secret-name=printenv-db-secret"
pe "oc set env dc/printenv READ_FROM_FILE=/dbconfig/appdburl"
pe "curl $(oc get route printenv|awk '{print $2}'|grep printenv)"
pe "review the configs from the pod"
pe "oc delete namespace a-boademo"

