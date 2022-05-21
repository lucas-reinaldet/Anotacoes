docker rm $(docker container ps -aq)

docker image rm $(docker image ls -aq) -f