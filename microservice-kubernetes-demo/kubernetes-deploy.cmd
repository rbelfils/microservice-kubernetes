@echo on
if not defined %DOCKER_ACCOUNT% echo set DOCKER_ACCOUNT=ryukunaga
docker login -u ryukunaga
if not %errorlevel%==0 (
echo "exit, restart docker for login correctly"
pause
exit
)
kubectl run apache --image=index.docker.io/%DOCKER_ACCOUNT%/microservice-kubernetes-demo-apache:latest --port=80
kubectl expose deployment/apache --type="LoadBalancer" --port 80
kubectl run catalog --image=index.docker.io/%DOCKER_ACCOUNT%/microservice-kubernetes-demo-catalog:latest --port=8080
kubectl expose deployment/catalog --type="LoadBalancer" --port 8080
kubectl run customer --image=index.docker.io/%DOCKER_ACCOUNT%/microservice-kubernetes-demo-customer:latest --port=8080
kubectl expose deployment/customer --type="LoadBalancer" --port 8080
kubectl run order --image=index.docker.io/%DOCKER_ACCOUNT%/microservice-kubernetes-demo-order:latest --port=8080
kubectl expose deployment/order --type="LoadBalancer" --port 8080
kubectl run hystrix-dashboard --image=index.docker.io/%DOCKER_ACCOUNT%/microservice-kubernetes-demo-hystrix-dashboard:latest --port=8080
kubectl expose deployment/hystrix-dashboard --type="LoadBalancer" --port 8080
