# # https://docs.confluent.io/platform/current/installation/installing_cp/deb-ubuntu.html

# wget -qO - https://packages.confluent.io/deb/7.2/archive.key | sudo apt-key add -

# sudo add-apt-repository "deb [arch=amd64] https://packages.confluent.io/deb/7.2 stable main"

# sudo add-apt-repository "deb https://packages.confluent.io/clients/deb $(lsb_release -cs) main"


# sudo apt-get update && sudo apt-get install confluent-platform

# # sudo apt-get update && \
# # sudo apt-get install confluent-platform && \
# # sudo apt-get install confluent-security

# # Download

# wget https://s3-us-west-2.amazonaws.com/confluent.cloud/confluent-cli/archives/latest/confluent_latest_linux_amd64.tar.gz

# tar -xzvf confluent_latest_linux_amd64.tar.gz  -C ~/

# rm -r confluent_latest_*

# echo '''
# export CONFLUENT_CURRENT=~/confluent
# export PATH=$CONFLUENT_CURRENT:$PATH
# ''' >> ~/.bashrc

# source ~/.bashrc

# # ->

# tickTime=2000

# # -----

# sudo nano /etc/kafka/zookeeper.properties
# sudo nano ~/kafka/config/zookeeper.properties

# # -> 

# # tickTime=2000
# # dataDir=/var/lib/zookeeper/
# # clientPort=2181
# # initLimit=5
# # syncLimit=2
# # server.1=zoo1:2888:3888
# # # server.2=zoo2:2888:3888
# # # server.3=zoo3:2888:3888
# # autopurge.snapRetainCount=3
# # autopurge.purgeInterval=24

# # server.<myid>=<hostname>:<leaderport>:<electionport>
# # myidé o número de identificação do servidor. 
# # O myidé definido criando um arquivo chamado myidno dataDir que contém um único 
# # inteiro em texto ASCII legível por humanos. Esse valor deve corresponder a um 
# # dos myidvalores do arquivo de configuração. Você verá um erro se outro membro 
# # do conjunto já tiver sido iniciado com um myidvalor conflitante.

# echo "1" > sudo /var/lib/zookeeper/mydir

# sudo nano /var/lib/zookeeper/mydir

# # ->

# 1

# # -----

# sudo nano /etc/kafka/server.properties

# # ->

# # ##################### Confluent Metrics Reporter #######################
# # # Confluent Control Center and Confluent Auto Data Balancer integration
# # #
# # # Uncomment the following lines to publish monitoring data for
# # # Confluent Control Center and Confluent Auto Data Balancer
# # # If you are using a dedicated metrics cluster, also adjust the settings
# # # to point to your metrics Kafka cluster.
# # metric.reporters=io.confluent.metrics.reporter.ConfluentMetricsReporter
# # confluent.metrics.reporter.bootstrap.servers=localhost:9092
# # #
# # # Uncomment the following line if the metrics cluster has a single broker
# # confluent.metrics.reporter.topic.replicas=1

# # --

# broker.id=1

# # or 

# #broker.id=0
# broker.id.generation.enable=true



# # -----

# sudo nano /etc/confluent-control-center/control-center-production.properties

# # ->

# # # host/port pairs to use for establishing the initial connection to the Kafka cluster
# # bootstrap.servers=<hostname1:port1,hostname2:port2,hostname3:port3,...>
# # # location for Control Center data
# # confluent.controlcenter.data.dir=/var/lib/confluent/control-center
# # # the Confluent license
# # confluent.license=<your-confluent-license>
# # # ZooKeeper connection string with host and port of a ZooKeeper servers
# # zookeeper.connect=<hostname1:port1,hostname2:port2,hostname3:port3,...>

# # -----


# echo """
# # Interceptor setup
# consumer.interceptor.classes=io.confluent.monitoring.clients.interceptor.MonitoringConsumerInterceptor
# producer.interceptor.classes=io.confluent.monitoring.clients.interceptor.MonitoringProducerInterceptor
# """ >> sudo '/etc/kafka/connect-distributed.properties'

# sudo nano /etc/schema-registry/schema-registry.properties

# # ->

# # # Specify the address the socket server listens on, e.g. listeners = PLAINTEXT://your.host.name:9092
# # listeners=http://0.0.0.0:8081

# # # The host name advertised in ZooKeeper. This must be specified if your running Schema Registry
# # # with multiple nodes.
# # host.name=192.168.50.1

# # # List of Kafka brokers to connect to, e.g. PLAINTEXT://hostname:9092,SSL://hostname2:9092
# # kafkastore.bootstrap.servers=PLAINTEXT://hostname:9092,SSL://hostname2:9092

# # -----

# sudo systemctl start confluent-zookeeper

# sudo systemctl start confluent-server

# sudo systemctl start confluent-schema-registry

# sudo systemctl start confluent-control-center

# sudo systemctl start confluent-kafka-connect

# sudo systemctl start confluent-kafka-rest

# sudo systemctl start confluent-ksqldb

# # leaderporté usado pelos seguidores para se conectar ao líder ativo. 
# # Essa porta deve estar aberta entre todos os membros do conjunto ZooKeeper.

# # electionporté usado para realizar eleições de líderes entre os membros do ensemble. 
# # Essa porta deve estar aberta entre todos os membros do conjunto ZooKeeper.

# # Os autopurge.snapRetainCounte autopurge.purgeIntervalforam definidos para limpar 
# # todos os instantâneos, exceto três, a cada 24 horas.

------------------------------------------------------------------

wget https://packages.confluent.io/archive/7.2/confluent-7.2.0.tar.gz

tar -xzvf confluent-7.2.0.tar.gz

rm -r confluent-7.2.0.tar.gz

ln -s confluent-7.2.0/ confluent

nano confluent/etc/kafka-rest/kafka-rest.properties

# ->

listeners=http://0.0.0.0:8082

bootstrap.servers=PLAINTEXT://localhost:9092

# <-

sudo nano /etc/nginx/sites-enabled/default

# -> Dentro de Servers

location = /rest {
    return 302 /rest/;
}

location /rest/ {
    gzip on;
    gzip_types application/json;
    auth_basic "Authentication required";
    auth_basic_user_file /opt/.htpasswd;
    proxy_pass http://127.0.0.1:8082/;
    proxy_http_version 1.1;
    proxy_set_header Host $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    add_header X-Content-Type-Options "nosniff";
    add_header Strict-Transport-Security "max-age=631138519";
}

sudo systemctl start nginx

# Reiniciar o serviço
sudo systemctl restart nginx

# <- Dentro de Servers

./confluent/bin/kafka-rest-start confluent/etc/kafka-rest/kafka-rest.properties

# Testar

curl -X POST \
     -H "Content-Type: application/vnd.kafka.json.v2+json" \
     -H "Accept: application/vnd.kafka.v2+json" \
     --data '{"records":[{"value":{ "name": "NCP Sheffield", "space": "A42", "occupied": true }}]}' \
     "http://localhost:8082/topics/carpark"

# Acessar topico via consumer e visualizar todas as mensagens
./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic carpark --group consumidores --from-beginning

################### Testar com conf diferentes do nginx

sudo nano /etc/nginx/sites-enabled/default

# -> Dentro de Servers

location = /test {
    return 302 /test/;
}

location /test/ {
    gzip on;
    gzip_types application/json;
    proxy_pass http://127.0.0.1:8082/topics/carpark;
    proxy_http_version 1.1;
    proxy_set_header Host $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    add_header X-Content-Type-Options "nosniff";
    add_header Strict-Transport-Security "max-age=631138519";
}

# <- Dentro de Servers

# Reiniciar o serviço

sudo nginx -t

sudo systemctl restart nginx

sudo systemctl status nginx

curl -X POST \
     -H "Content-Type: application/vnd.kafka.json.v2+json" \
     -H "Accept: application/vnd.kafka.v2+json" \
     --data '{"records":[
            {"value":{ "name": "1", "space": "1", "occupied": true }},
            {"value":{ "name": "2", "space": "2", "occupied": true }},
            {"value":{ "name": "3", "space": "3", "occupied": true }},
            {"value":{ "name": "4", "space": "4", "occupied": true }},
            {"value":{ "name": "5", "space": "5", "occupied": true }},
            {"value":{ "name": "6", "space": "6", "occupied": true }}
        ]}' \
     "http://localhost/test/"


curl -I "http://localhost/test/"


# --------

# Cadastro de Schema
# https://docs.confluent.io/platform/current/schema-registry/develop/using.html

# confluent/bin/zookeeper-server-start ./confluent/etc/kafka/zookeeper.properties
# confluent/bin/kafka-server-start ./confluent/etc/kafka/server.properties
confluent/bin/schema-registry-start ./confluent/etc/schema-registry/schema-registry.properties

# Cadastro teste
curl -X POST -H "Content-Type: application/vnd.schemaregistry.v1+json" \
  --data '{"schema": "{\"type\": \"string\"}"}' \
  http://localhost:8081/subjects/Kafka-key/versions

curl -X POST -H "Content-Type: application/vnd.schemaregistry.v1+json" \
  --data '{"schema": "{\"type\": \"string\"}"}' \
   http://localhost:8081/subjects/Kafka-value/versions

# listar
curl -X GET http://localhost:8081/subjects

curl -X GET http://localhost:8081/subjects/Kafka-key/versions/1

curl -X DELETE http://localhost:8081/subjects/Kafka-key/versions/1

curl -X GET http://localhost:8081/schemas/ids/1


# Verificar c ompatibilidade
curl -X POST -H "Content-Type: application/vnd.schemaregistry.v1+json" \
  --data '{"schema": "{\"type\": \"string\"}"}' \
  http://localhost:8081/compatibility/subjects/Kafka-value/versions/latest



# Cadastro de um schema

curl -X POST -H "Content-Type: application/vnd.schemaregistry.v1+json" --data '{"schema": "{\"type\":\"record\",\"name\":\"Payment1\",\"namespace\":\"my.examples\",\"fields\":[{\"name\":\"id\",\"type\":\"string\"},{\"name\":\"amount\",\"type\":\"double\"}]}"}' http://localhost:8081/subjects/my-kafka-value/versions

curl -X POST -H "Content-Type: application/vnd.schemaregistry.v1+json" --data '{"schema": "{\"type\":\"fixed\",\"name\":\"schema_test\",\"namespace\":\"my.examples\",\"fields\":[{\"name\":\"id\",\"type\":\"string\"},{\"name\":\"amount\",\"type\":\"double\"}]}"}' http://localhost:8081/subjects/teste/versions

# The basic structure of a schema appears prepopulated in the editor as a starting point. 
# Enter the schema in the editor:

# name: Enter a name for the schema if you do not want to accept the default, which is determined by the 
# subject name strategy. The default is schema_type_topic_name. Required.

# type: Either record, enum, union, array, map, or fixed. (The type record is specified at the schema’s 
# top level and can include multiple fields of different data types.) Required.

# namespace: Fully-qualified name to prevent schema naming conflicts. String that qualifies the schema name. 
# Optional but recommended.

# fields: JSON array listing one or more fields for a record. Required.

# Each field can have the following attributes:

# name: Name of the field. Required.
# type: Data type for the field. Required.
# doc: Field metadata. Optional but recommended.
# default: Default value for a field. Optional but recommended.
# order: Sorting order for a field. Valid values are ascending, descending, or ignore. Default: Ascending. Optional.
# aliases: Alternative names for a field. Optional.

# {
#   "type": "record",
#   "name": "Payment",
#   "namespace": "io.confluent.examples.clients.basicavro",
#   "fields": [
#     {
#       "name": "id",
#       "type": "string"
#     },
#     {
#       "name": "amount",
#       "type": "double"
#     }
#   ]
# }

curl -X PUT -H "Content-Type: application/vnd.schemaregistry.v1+json" --data '{"compatibility": "FULL"}' http://localhost:8081/config/my-kafka-value

# BACKWARD: (default) consumers using the new schema can read data written by producers using the latest registered schema
# BACKWARD_TRANSITIVE: consumers using the new schema can read data written by producers using all previously registered schemas
# FORWARD: consumers using the latest registered schema can read data written by producers using the new schema
# FORWARD_TRANSITIVE: consumers using all previously registered schemas can read data written by producers using the new schema
# FULL: the new schema is forward and backward compatible with the latest registered schema
# FULL_TRANSITIVE: the new schema is forward and backward compatible with all previously registered schemas
# NONE: schema compatibility checks are disabled

curl -X GET http://localhost:8081/schemas/types


# namespace: a fully qualified name that avoids schema naming conflicts
# type: Avro data type, one of record, enum, union, array, map, fixed
# name: unique schema name in this namespace
# fields: one or more simple or complex data types for a record. The first field in this record is called id, 
# and it is of type string. The second field in this record is called amount, and it is of type double.








curl -X POST -H "Content-Type: application/vnd.schemaregistry.v1+json" \
  --data '{"schema": "{\"type\": \"fixed\", \"name\": \"teste\"}"}' \
  http://localhost:8081/subjects/teste