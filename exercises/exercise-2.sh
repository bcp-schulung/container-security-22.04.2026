docker build -t mynginx .

docker run -d -p 8080:80 --name mynginx mynginx

docker ps

curl http://localhost:8080

docker images

docker tag mynginx:latest registry.it-scholar.com/$USER/mynginx:v1

docker push registry.it-scholar.com/$USER/mynginx:v1