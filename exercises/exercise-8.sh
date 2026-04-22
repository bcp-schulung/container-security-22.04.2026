kubectl create deployment frontend --image=nginx:1.29.6
kubectl create deployment backend --image=nginx:1.29.6
kubectl create deployment db --image=nginx:1.29.6

kubectl get deployments

kubectl expose deployment frontend --port=80 --type=NodePort
kubectl expose deployment backend --port=80 
kubectl expose deployment db --port=80

kubectl get services

kubectl apply -f networkpolicies.yaml