
# entrando na pasta odne esta o arquivo docker compose
cd script/

# iniciando o projeto
docker compose up

# Observação:
environment:
    # Nome do node
    - node.name=elasticsearch
    # Dizendo o tipo do cluster
    - discovery.type=single-node
    # Desativa a autenticação
    - xpack.security.enabled=false
    - ES_JAVA_OPTS=-Xms1g -Xmx1g
      
# Acessar a página do elastic: 0.0.0.0:9200
# Resultado:
{
  "name" : "elasticsearch",
  "cluster_name" : "docker-cluster",
  "cluster_uuid" : "OVZ4w1BuSxOS7eZD2qxReQ",
  "version" : {
    "number" : "8.10.2",
    "build_flavor" : "default",
    "build_type" : "docker",
    "build_hash" : "6d20dd8ce62365be9b1aca96427de4622e970e9e",
    "build_date" : "2023-09-19T08:16:24.564900370Z",
    "build_snapshot" : false,
    "lucene_version" : "9.7.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}

# Acessar a página do Kibana: 0.0.0.0:5601

# Adicionando autenticação no Elastic
xpack.security.enabled=true
ELASTIC_PASSWORD=teste123


# Criando um arquivo de configuração do Kibana

# criar um arquivo no mesmo diretorio do docker compose file: 
kibana.yaml

# Conexão com o Elasticsearch
server.host: "0.0.0.0"
elasticsearch.hosts: [ "http://elasticsearch:9200" ]

# Segurança
xpack.security.enabled: true
xpack.encryptedSavedObjects.encryptionKey: "qANYyOE+o0TzKcrjVTkxPg2tp0Ytxuks0AIpQEeNQFE="

# Configuração de autenticação
elasticsearch.username: "kibana_system"
elasticsearch.password: "teste123"

# Com o container ativo, acesse:
docker exec -it 53df26e58f15 bash

# Agora executa:
bin/elasticsearch-setup-passwords -v interactive

# Vai aparecer uma serie de perguntas para definir senhas das aplicações
# Exemplo:

You will be prompted to enter passwords as the process progresses.
Please confirm that you would like to continue [y/N]y

Enter password for [elastic]: 
Reenter password for [elastic]: 
Enter password for [apm_system]: 
Reenter password for [apm_system]: 
Enter password for [kibana_system]: 
Reenter password for [kibana_system]: 
Enter password for [logstash_system]: 
Reenter password for [logstash_system]: 
Enter password for [beats_system]: 
Reenter password for [beats_system]: 
Enter password for [remote_monitoring_user]: 
Reenter password for [remote_monitoring_user]: 
Changed password for user [apm_system]
Changed password for user [kibana_system]
Changed password for user [kibana]
Changed password for user [logstash_system]
Changed password for user [beats_system]
Changed password for user [remote_monitoring_user]
Changed password for user [elastic]


# É necessário se preocupar com a licença do Elastic Search
# Ele é opensource, mas dependendo da situação, é necessário
# realizar a compra