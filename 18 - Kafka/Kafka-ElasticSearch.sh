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
curl http://http://127.0.0.1:9200

# criar um indice no elasticsearch 
curl -X PUT "http://127.0.0.1:9200/meuindice?pretty"

# inserir dados 
curl -H 'Content-Type: application/json' -XPUT 127.0.0.1:9200/meuindice/_doc/1010 -d '
{
"nome" : "estudante" ,
"assunto" : "kafka",
"ano" : 2014
} '

# testar
curl -XGET 127.0.0.1:9200/meuindice/_search?pretty

# download plugin do connect
https://www.confluent.io/hub/confluentinc/kafka-connect-elasticsearch?_ga=2.155488187.1246868404.1632326328-39433521.1632326328

# elasticsearch-connect.propertie em arquivo separado

# editar connect-standalone.properties
key.converter.schemas.enable=false
value.converter.schemas.enable=false

# rodar o connect no modo standalone
./connect-standalone.sh ../config/connect-standalone.properties ../config/elasticsearch-connect.properties

# cria um producer
./kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --topic elastic --create --partitions 3 --replication-factor 1

# verificar no elasticsearch
curl -XGET 127.0.0.1:9200/meuindice/_search?pretty


