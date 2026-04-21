kubectl create namespace team-alice

openssl genrsa -out alice.key 3072

openssl req -new -key alice.key -out alice.csr -subj "/CN=alice"

cat alice.csr | base64 | tr -d "\n"

kubectl apply -f alice-csr.yaml

kubectl certificate approve alice

kubectl get csr alice -o jsonpath='{.status.certificate}' | base64 -d > alice.crt

kubectl config set-credentials alice \
  --client-key=alice.key \
  --client-certificate=alice.crt \
  --embed-certs=true

kubectl config get-contexts

kubectl config set-context alice-team-alice \
  --cluster=<YOUR_CLUSTER_NAME> \
  --user=alice \
  --namespace=team-alice

kubectl create rolebinding alice-admin-binding \
    --clusterrole=admin \
    --user=alice \
    --namespace=team-alice

kubectl config get-contexts

kubectl config use-context alice-team-alice

kubectl get pods