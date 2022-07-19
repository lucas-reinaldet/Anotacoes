
# Testar 
curl https://127.0.0.1:9200

# Desabilitar a segurança de usuário
# Não é recomendado, mas para testes locais pode ser realizado, porem com muita cautela.
sed 's/xpack.security.enabled: true/xpack.security.enabled: false/g' elasticsearch.yml > elasticsearch.yml

# Criar um indice meuindice no elasticsearch 
curl -X PUT "127.0.0.1:9200/meuindice?pretty"

# Inserir dados 
curl -H 'Content-Type: application/json' -XPUT 127.0.0.1:9200/meuindice/_doc/1010 -d '
{
"nome" : "estudante" ,
"assunto" : "kafka",
"ano" : 2014
} '

# Testar
curl -XGET 127.0.0.1:9200/meuindice/_search?pretty

# Download plugin do connect
https://www.confluent.io/hub/confluentinc/kafka-connect-elasticsearch?_ga=2.155488187.1246868404.1632326328-39433521.1632326328

# elasticsearch-connect.propertie em arquivo separado