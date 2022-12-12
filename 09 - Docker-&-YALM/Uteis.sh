
### Uteis

docker run -it -d api_itscampro:1.0 sh

docker exec -it cdc496f51d99 sh

docker container stop cdc496f51d99

docker image rm -f $(docker image ls -aq)
docker container rm -f $(docker container ps -aq) 

docker stop $(docker container ps -aq)