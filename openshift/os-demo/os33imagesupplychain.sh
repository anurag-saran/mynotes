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
pe "oc delete project a-demodevenv-supplychain"
pe "oc new-build https://github.com/anurag-saran/container-supply-chain.git --context-dir=corebuild --strategy=docker --name=corebuild"
echo  "oc logs -f bc/corebuild"
pe "oc new-build https://github.com/anurag-saran/container-supply-chain.git --context-dir=httpd-php --strategy=docker --name=httpd-php"
echo "oc logs -f bc/httpd-php"
pe "oc new-build https://github.com/anurag-saran/container-supply-chain.git --context-dir=wordpress --strategy=docker --name=wordpress --allow-missing-images"
echo "oc logs -f bc/wordpress"
pe "oc new-app mysql -e MYSQL_ROOT_PASSWORD=password"
pe "oc new-app wordpress -e WORDPRESS_DB_HOST=mysql:3306 -e WORDPRESS_DB_USER=root -e WORDPRESS_DB_PASSWORD=password"

