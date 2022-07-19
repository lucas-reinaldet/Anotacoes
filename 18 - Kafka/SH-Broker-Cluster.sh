
# Levantar mais de um Broker

# parar kafka e zookeeper
./kafka-server-stop.sh
./zookeeper-server-stop.sh

# apagar o diretorio de topicos
rm -r /tmp/kafka*
rm -r /tmp/zookeeper

#copiamos o arquivo de configuração do server
cp kafka/config/server.properties kafka/config/server.properties0
cp kafka/config/server.properties kafka/config/server.properties1
cp kafka/config/server.properties kafka/config/server.properties2

#Modificar os parametros
# File 0
broker.id=0
listeners=PLAINTEXT://:9990
log.dirs=/tmp/kafka-logs-00

# File 1
broker.id=1
listeners=PLAINTEXT://:9991
log.dirs=/tmp/kafka-logs-01

# File 2
broker.id=2
listeners=PLAINTEXT://:9992
log.dirs=/tmp/kafka-logs-02

# inicia zookeeper
./kafka/bin/zookeeper-server-start.sh kafka/config/zookeeper.properties

# inicia brokers
./kafka/bin/kafka-server-start.sh kafka/config/server.properties0
./kafka/bin/kafka-server-start.sh kafka/config/server.properties1
./kafka/bin/kafka-server-start.sh kafka/config/server.properties2

# checar 
# vai abrir um shel do zookeeper
./kafka/bin/zookeeper-shell.sh localhost:2181 

# Listar os id dos Broker ativos
ls /brokers/ids

# Pegar informacoes de um broker especifico
get /brokers/ids/1


# ----------------

# Utilizando o cluster
# criamos um novo tópico com 3 particoes e 3 fator de replicação
./kafka/bin/kafka-topics.sh --bootstrap-server localhost:9990 --topic mensagens --create --partitions 3 --replication-factor 3

# descreve
./kafka/bin/kafka-topics.sh --bootstrap-server localhost:9990 --topic mensagens --describe

# Replicas (Apresenta o ID dos Brokers)
# Topic: mensagens	Partition: 0	Leader: 1	Replicas: 1,0,2Isr: 1,0,2
# Topic: mensagens	Partition: 1	Leader: 0	Replicas: 0,2,1Isr: 0,2,1
# Topic: mensagens	Partition: 2	Leader: 2	Replicas: 2,1,0Isr: 2,1,0


# Criando um topico com fator de replicação 3 com numero minimo de replicas 3,
# Vale mencionar que não é possivel passar o aprametro com --, sendo necessario passar
# o parametro --config.
./kafka/bin/kafka-topics.sh --bootstrap-server localhost:9990 --topic mensagens-test --create --partitions 3 --replication-factor 3 --config min.insync.replicas=3

# Definindo o parametro de resposta do Producer com all
./kafka/bin/kafka-console-producer.sh --bootstrap-server localhost:9990 --topicmensagens-test --request-required-acks all

# Cria um consumidor com um grupo
# Utilizando o Broker 00
./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9990 --topicmensagens-test --group consumidores

# Utilizando o Broker 03
./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9992 --topicmensagens-test --group consumidores

# descrever grupos
./kafka/bin/kafka-consumer-groups.sh --bootstrap-server localhost:9990 --describe --group consumidores

# mostrar dados
cd /tmp/kafka-logs/
