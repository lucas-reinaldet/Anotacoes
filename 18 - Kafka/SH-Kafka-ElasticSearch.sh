# Install elastisearch
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.3.2-linux-x86_64.tar.gz

# Descompactar
tar -xzf elasticsearch-8.3.2-linux-x86_64.tar.gz

# Mover para o home
mv elasticsearch-8.3.2 ~/

# Criar Link Simbolico
ln -s elasticsearch-8.3.2 elasticsearch

# iniciar
./elasticsearch/bin/elasticsearch

# testar 
curl http://127.0.0.1:9200

# criar um indice no elasticsearch 
curl -X PUT "http://127.0.0.1:9200/meuindice?pretty"
# curl -X DELETE "http://127.0.0.1:9200/meuindice"

# inserir dados 
curl -H 'Content-Type: application/json' -XPUT 127.0.0.1:9200/meuindice/_doc/1010 -d '
{
"nome" : "estudante" ,
"assunto" : "kafka",
"ano" : 2014
} '

# testar
curl -X GET 127.0.0.1:9200/meuindice/_search?pretty

# download plugin do connect
# O Elasticsearch versão 8 não é compatível com o Confluent Elasticsearch Sink Connector Versão 11.1.10,
https://www.confluent.io/hub/confluentinc/kafka-connect-elasticsearch?_ga=2.155488187.1246868404.1632326328-39433521.1632326328

# verificar no elasticsearch
curl -XGET 127.0.0.1:9200/meuindice/_search?pretty

# Download do plugin
# Obs: Download installation File Zip
https://www.confluent.io/hub/confluentinc/kafka-connect-elasticsearch

# Entrar na pasta Downloads

cd Downloads/

# Extrair arquivo
unzip confluentinc-kafka-connect-elasticsearch-13.1.0.zip

# Mover todo o conteudo de lib do confluentinc-kafka-connect-elasticsearch 
# para a pasta lib do Kafka
mv confluentinc-kafka-connect-elasticsearch-13.1.0/lib/* ~/kafka/libs/

# Excluir arquivo zip e pasta
rm -r confluentinc-kafka-connect-elasticsearch*

# Criar arquivo de propriedades
# name = definir nome do conector, necessário ser unico.
# connector.class = Classe do conector do arquivo java
# tasks.max = Quantidade de tarefas em Paralelo
# topics = nome do Topic onde será carregado as mensagens para o elasticsearch
# connection.url = URL do Elasticsearch ao qual será conectado
# type.name = Tipo no Elasticsearch
# key.ignore = Identifica se é necessário ignorar a chave, caso False é necessário ter a key indicada (Producer que indica)
# schema.ignore = 
# schemas.enable = 
# 
# Precisa indicar ao Elasticsearch que é necessário armazenar os topics em um index
# criado para tal funcionalidade.
# transforms: addSuffix
#
# Definindo as propriedades de addSuffix
# transforms.addSuffix.type: org.apache.kafka.connect.transforms.RegexRouter
# transforms.addSuffix.regex: elastic.*
#
# Indicando o indice onde será armazenado as informações oriundas do Apache Kafka.
# transforms.addSuffix.replacement: meuindice

# Criando o arquivo de configuração

nano ~/kafka/config/elasticsearch-connect.properties

# conteudo do arquivo

name=elasticsearch-sink
connector.class=io.confluent.connect.elasticsearch.ElasticsearchSinkConnector
tasks.max=1
topics=elastic
connection.url=http://localhost:9200
type.name=log
key.ignore=true
schema.ignore=true
schemas.enable=false
transforms: addSuffix
transforms.addSuffix.type: org.apache.kafka.connect.transforms.RegexRouter
transforms.addSuffix.regex: elastic.*
transforms.addSuffix.replacement: meuindice

# ou 

echo """
name=elasticsearch-sink
connector.class=io.confluent.connect.elasticsearch.ElasticsearchSinkConnector
tasks.max=1
topics=meuindice
connection.url=http://localhost:9200
type.name=log
key.ignore=true
schema.ignore=true
schemas.enable=false
transforms: addSuffix
transforms.addSuffix.type: org.apache.kafka.connect.transforms.RegexRouter
transforms.addSuffix.regex: elastic.*
transforms.addSuffix.replacement: meuindice
""" > ~/kafka/config/elasticsearch-connect.properties


# Alterando algumas configurações do Kafka

# Utilizando Nano ou

nano ~/kafka/config/connect-standalone.properties
key.converter.schemas.enable=true -> false
value.converter.schemas.enable=true -> false

# Utilizando o comando SED

sed -i 's/key.converter.schemas.enable=true/key.converter.schemas.enable=false/g' ~/kafka/config/connect-standalone.properties
sed -i 's/value.converter.schemas.enable=true/value.converter.schemas.enable=false/g' ~/kafka/config/connect-standalone.properties

# Verificar
# internal.key.converter=org.apache.kafka.connect.json.JsonConverter
# internal.value.converter=org.apache.kafka.connect.json.JsonConverter
# internal.key.converter.schemas.enable=false
# internal.value.converter.schemas.enable=false


# cria um Topic
./kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --topic meuindice --create

# ./kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --topic elastic --delete

# rodar o connect no modo standalone
cd ~
./kafka/bin/connect-standalone.sh ~/kafka/config/connect-standalone.properties ~/kafka/config/elasticsearch-connect.properties


# Testar

# Criar um Producer
./kafka/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic meuindice

# Mensagem
{"nome" : "Teste 02" , "assunto" : "Teste1s","ano" : 20114}

# Verificar se as mensagens estao no TOPIC
./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic meuindice --from-beginning

# Verificar se a mensagem foi cadastrada
curl -X GET 127.0.0.1:9200/meuindice/_search?pretty
