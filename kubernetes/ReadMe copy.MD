# Build a image and push it to docker hub.
docker build .
docker run -p 3000:3000 -it 7a4cfb57fbb0
docker tag 7a4cfb57fbb0 asaran/k8s-demo
docker login
docker push asaran/k8s-demo
kubectl get node
kubectl create -f first-app/helloworld.yml
kubectl describe pod nodehelloworld.example.com
cat first-app/helloworld.yml 
# Forwad traffic
kubectl port-forward nodehelloworld.example.com 8091:3000
# Expose service
kubectl expose pod nodehelloworld.example.com --type=NodePort --name nodehelloword-service
kubectl get services
# Get Service
minikube service nodehelloword-service --url
curl http://192.168.99.100:30025

kubectl attach nodehelloworld.example.com
# Run a command inside a pod
kubectl exec nodehelloworld.example.com -- ls /app
kubectl exec nodehelloworld.example.com -- touch aa.txt
# Get the pod URL so as to connect from another pod/
kubectl get services
kubectl describe service nodehelloword-service
# Endpoints:                172.17.0.7:3000
kubectl run -i --tty busybox --image=busybox --restart=Never -- sh
#Update using your yaml so it can be checked in.
kubectl scale --replicas=1 rc/helloworld-controller
kubectl delete rc/helloworld-controller
kubectl scale --replicas=1 rc/helloworld-controller
# Deployment Object
kubectl get deployments
kubectl get rs
kubectl get pods --show-lables
# get deployment status
kubectl rollout status deployment/helloworld-deployment
# run with image label version 2
kubectl create -f deployment/helloworld.yml --record="my notes"
kubectl expose deployment helloworld-deployment --type=NodePort
minikube service helloworld-deployment --url
kubectl set image deployment/helloworld-deployment k8s-demo=asaran/k8s-demo:2
kubectl rollout history deployment/helloworld-deployment
kubectl rollout undo deployment/helloworld-deployment
kubectl rollout undo deployment/helloworld-deployment --to-revision=n
# Service
kubectl create -f first-app/helloworld-nodeport-service.yml 
# label nodes
kubectl label node node1 hardware=HighCPU
# Now use nodeSelector in Kind:Pod
kubectl create -f deployment/helloworld-nodeselector.yml 
kubectl label nodes minikube hardware=high-spec
# Health Check
kubectl create -f deployment/helloworld-healthcheck.yml 
kubectl edit deployment/helloworld-deployment
# Secrets
kubectl create -f deployment/helloworld-secrets-volumes.yml 
kubectl create -f deployment/helloworld-secrets.yml 
kubectl exec helloworld-deployment-volsec-6cfc6d654f-psgpr  -it -- /bin/bash
# Running two containers inside a pod. Use secrets of DB.
kubectl create -f wordpress/wordpress-secrets.yml
kubectl create -f wordpress/wordpress-single-deployment-no-volumes.yml
kubectl create -f wordpress/wordpress-service.yml 
minikube service wordpress-service --url
# Service
kubectl create -f service-discovery/secrets.yml 
kubectl create -f service-discovery/database.yml 
kubectl create -f service-discovery/database-service.yml 
kubectl create -f service-discovery/helloworld-db.yml 
kubectl create -f service-discovery/helloworld-db-service.yml 
# ConfigMap
kubectl create configmap nginx-config --from-file=configmap/reverseproxy.conf
kubectl create -f configmap/nginx.yml 
kubectl create -f configmap/nginx-service.yml 
minikube service helloworld-nginx-service --url
kubectl exec -it helloworld-nginx -c nginx -- bash
/#ps x
/# cat /etc/nginx/conf.d/reverseproxy.conf
# Ingress
vi ingress/nginx-ingress-controller.yml 
kubectl create -f ingress/ingress.yml -f ingress/nginx-ingress-controller.yml -f ingress/echoservice.yml -f ingress/helloworld-v1.yml -f ingress/helloworld-v2.yml 
curl 192.168.99.100 -H 'Host: helloworld-v1.example.com'
curl 192.168.99.100 -H 'Host: helloworld-v2.example.com'
# Volumes on AWS
aws ec2 create-volume --size 10 --region eu-west-1 --availability-zone eu-west-1a --volume-type gp2
vi volumes/helloworld-with-volume.yml --> Insert volumeID
kubectl create -f volumes/helloworld-with-volume.yml
aws ec2 delete-volume --volume-id vol-8989798987789
# VolumeClaim - DB and wordpress
# for mysql we use block storage and for wordpress we use EFS.
aws efs create-file-system --creation-token 2
aws efs create-mount-target --file-system-id fs-68786786e --subnet-id subnet-999987e2 --security-groups sg-f12121
vi worldpress-web.yml --> add the fileSystemID : 
kubectl create -f storage.yml -f pv-claims.yaml -f wordpress-secrets.yml -f wordpress-db.yml -f wordpress-db-service.yml
# wait for the efs to be created.
kubectl create -f wordpress-web.yml -f wordpress-service.yml
# PetSets ordinal no of pods and volume. order startup abd teardown.
# Daemon  sets: Run a pod on every node.
# Addons
# Download zip from https://github.com/kubernetes/heapster
kubectl create -f deploy/kube-config/influxdb/
minikube service  monitoring-grafana --namespace=kube-system --url
# HPA 
kubectl create -f autoscaling/hpa-example.yml 
# Quotas: Request : Min amount needed. ResLimit: Limit imposed
kubectl create -f resourcequotas/resourcequota.yml 
kubectl create -f  resourcequotas/helloworld-no-quotas.yml 
kubectl get  rs --namespace=myspace
kubectl describe rs/helloworld-deployment-noquota-64b4c45585 --namespace=myspace
kubectl get  deployment
kubectl get  deployment --namespace=myspace
kubectl delete deploy/helloworld-deployment-noquota --namespace=myspace
kubectl create -f resourcequotas/helloworld-with-quotas.yml 
kubectl describe quota/compute-quota --namespace=myspace
kubectl create -f resourcequotas/defaults.yml 
kubectl create -f resourcequotas/helloworld-no-quotas.yml 
# User Management : 1 normal user used with kubectl and not managed using objects
# normal user : Use cleint cert/token, proxy/basic auth/OpenID, webhooks
# username, UID, grops and extra fields/ ABAC and RBAC
# service user managed by object in kube. Use secrets. Specific to namespace.
# Creating a new key for a new user: 
openssl genrsa -out myuser.pem 2048
# Creating a certificate request: 
openssl req -new -key myuser.pem -out myuser-csr.pem -subj "/CN=myuser/O=myteam/"
# Creating a certificate: 
openssl x509 -req -in myuser-csr.pem -CA /path/to/kubernetes/ca.crt -CAkey /path/to/kubernetes/ca.key -CAcreateserial -out myuser.crt -days 10000
# update  ~/.kube/config
# drain a node
kubectl drain minikube --force











