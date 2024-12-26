sudo lsof -i tcp:9000
sudo lsof -i tcp:9001
sudo kill -9 PID

docker stop minio1
docker rm minio1

nmao localhost