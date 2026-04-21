kubectl create namespace team-alice

openssl genrsa -out alice.key 3072

openssl req -new -key alice.key -out alice.csr -subj "/CN=alice"

cat alice.csr | base64 | tr -d "\n"

kubectl apply -f alice-csr.yaml