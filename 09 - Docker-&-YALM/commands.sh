docker rm $(docker container ps -aq)

docker image rm $(docker image ls -aq) -f

apt-get update && apt-get install -y iputils-ping