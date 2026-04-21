kubectl create deployment bc-nginx --image=registry.it-scholar.com/bc/mynginx:v1 --replicas=3
kubectl get pods
kubectl get deployment bc-nginx
kubectl expose deployment bc-nginx --port=80 --type=NodePort
kubectl get services
curl http://<IP_ADDRESS>:<NodePort>