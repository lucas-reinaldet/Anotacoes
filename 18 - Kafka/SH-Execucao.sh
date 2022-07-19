
# Diretório do Usuário
cd ~

# iniciar zookeeper
./kafka/bin/zookeeper-server-start.sh kafka/config/zookeeper.properties

# iniciar broker
./kafka/bin/kafka-server-start.sh kafka/config/server.properties

# Parar Serviço Kafka
./kafka-server-stop.sh

# Parar serviço zookeeper
./zookeeper-server-stop.sh