docker build -t mynginx .

docker run -d -p 8080:80 --name mynginx mynginx

docker ps

curl http://localhost:8080

