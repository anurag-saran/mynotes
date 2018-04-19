#!/usr/bin/env bash

########################
# include the master
########################
. demo-master.sh
DEMO_PROMPT="${GREEN}anurags-MBP-2:os-demos anuragsaran$  ${BLACK}"
clear
      description: Default secret file with name 'jboss' and password 'mykeystorepass'
# create pvc decision-cental-dev-rhdmcentr-pvol in advance.
# Create the certs in advance
echo "# Lets create project"
pe "oc new-project rhdm-wellsdemo --display-name=rhdm-wellsdemo"
#pe "oc project rhdm-wellsdemo"
# pe "keytool -genkey -keyalg RSA -alias jboss  -keystore keystore.jks -storepass Password@123 -validity 360 -keysize 2048"
pe "oc create -f rhdm70-image-streams.yaml"
#pe "oc create secret generic kieserver-app-secret --from-file=keystore.jks"
pe "oc create -f kieserver-app-secret.yaml"
#pe "oc create serviceaccount kieserver-service-account"
pe "oc secret add sa/kieserver-service-account secret/kieserver-app-secret"
# pe "keytool -genkey -keyalg RSA -alias jboss-dc  -keystore dc-keystore.jks -storepass Password@123 -validity 360 -keysize 2048"
# pe "oc create secret generic decisioncentral-app-secret --from-file=dc-keystore.jks"
pe "oc create -f decisioncentral-app-secret.yaml"
#pe "oc create serviceaccount decisioncentral-service-account"
pe "oc secret add sa/decisioncentral-service-account secret/decisioncentral-app-secret"
pe "oc create -f rhdm70-full.yaml"
pe "oc new-app --template=rhdm70-full-persistent -p  APPLICATION_NAME=decision-cental-dev -p ADMIN_PASSWORD=Password@123 -p KIE_ADMIN_PWD=Password@123 -p KIE_SERVER_CONTROLLER_PWD=Password@123 -p KIE_SERVER_PWD=Password@123 -p KIE_SERVER_ID=kie-server-01 -p DECISION_CENTRAL_HTTPS_SECRET=decisioncentral-app-secret -p DECISION_CENTRAL_HTTPS_KEYSTORE=keystore.jks -p DECISION_CENTRAL_HTTPS_NAME=jboss -p DECISION_CENTRAL_HTTPS_PASSWORD=mykeystorepass -p KIE_SERVER_HTTPS_SECRET=kieserver-app-secret -p KIE_SERVER_HTTPS_KEYSTORE=keystore.jks -p KIE_SERVER_HTTPS_NAME=jboss -p KIE_SERVER_HTTPS_PASSWORD=mykeystorepass -p IMAGE_STREAM_NAMESPACE=rhdm -p MAVEN_REPO_PASSWORD=Password@123"
# pe " The user name/password for accessing the Decision Central interface is adminUser/Password@123. The user name/password for calls to the Decision Server is executionUser/Password@123"
echo "Use --> https://github.com/jbossdemocentral/rhdm7-qlb-loan-demo-repo.git executionUser/Password@123"
#echo "Use-->rhdm-kieserver-hellorules=com.redhat.demo.qlb:loan-application:1.0"

