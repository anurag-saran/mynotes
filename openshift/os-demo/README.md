# os-demo
https://master-1.oscid17.tryopenshift.online:8443/

user: anuragadmin
Password: pass@123

A/B Deployment

https://github.com/anurag-saran/ab-deploy

oc annotate route/bluegreen haproxy.router.openshift.io/balance=roundrobin

oc annotate route/? haproxy.router.openshift.io/balance=roundrobin

for i in {1..20}; do curl http://aabb-aa.paas.rdu.salab.redhat.com/; echo ""; done

for i in {1..20}; do curl http://?/; echo ""; done
