#!/usr/bin/env bash

########################
# include the master
########################
. demo-master.sh
DEMO_PROMPT="${GREEN}anurags-MBP-2:os-demos anuragsaran$  ${BLACK}"
clear


echo "# Login to box https://10.1.2.2:8443/console"
# echo "# oc login https://10.1.2.2:8443/"
#pe "pe "cd /root/os-demo"
#pe "oc delete project a-demo-configmaps"
#pe "oc new-project a-demo-configmaps --display-name=\"A Demo for config maps\""
#pe "oc project a-demo-configmaps"
#pe "oc create -f springboot-imagestream.json -n a-demo-configmaps"	
#pe "oc new-app springboot~https://github.com/anurag-saran/spring-sample-app --name=springapp"
#echo "---------------------------------------------------------------> Create mysql through UI: simpledb-user/password"
#pe "oc get service"
#pe "oc get route"
#pe "oc expose service springapp"
#pe "oc get route"
#pe "cp application.properties.mysql application.properties -n"
#pe "cat application.properties"
#pe "oc create configmap app-props --from-file=application.properties"
#pe "oc set volumes dc/springapp --add -m /opt/app-root/src/config --configmap-name=app-props"
#pe "curl http://springapp-a-demo-configmaps.apps.anuragsdemo.com/dbtest"
#pe "cat  application.properties"
#pe "oc describe configmap app-props"
#pe "oc new-app --template=postgresql-ephemeral --param=POSTGRESQL_USER=user,POSTGRESQL_PASSWORD=password,POSTGRESQL_DATABASE=sampledb -n a-demo-configmaps"
echo "create table and add records to the new db"
echo "Update configmap to new url i.e: jdbc:postgresql://postgresql.a-demo-configmaps:5432/sampledb"
pe "oc edit configmap app-props"
pe "curl -X POST http://springapp-a-demo-configmaps.apps.anuragsdemo.com/refresh"
pe "curl http://springapp-a-demo-configmaps.apps.anuragsdemo.com/dbtest"
echo " ---------------------------------------------> Question Time"
# oc rsh postgresql-1-g9y2w
# psql -h 127.0.0.1 -U $POSTGRESQL_USER -q -d $POSTGRESQL_DATABASE
# CREATE TABLE IF NOT EXISTS customer ( CUST_ID serial primary key,  NAME varchar(100) NOT NULL, AGE integer NOT NULL);
# insert into customer (name,age) values ('Joe postgresql', 100);
# insert into customer (name,age) values ('Jack postgresql', 150);
# insert into customer (name,age) values ('Ann postgresql', 200);
# select * from customer;
#pe "\dt"
#pe "\l"
#pe "\q"

