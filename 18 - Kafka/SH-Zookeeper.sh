
cd ~

# iniciar zookeeper
./kafka/bin/zookeeper-server-start.sh kafka/config/zookeeper.properties

# Parar serviço zookeeper
./zookeeper-server-stop.sh

# checar informações no zookeeper:
# vai abrir um shel do zookeeper
./kafka/bin/zookeeper-shell.sh localhost:2181 

# Listar os id dos Broker ativos
ls /brokers/ids

# Pegar informacoes de um broker especifico
get /brokers/ids/1
