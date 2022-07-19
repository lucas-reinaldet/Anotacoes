# File Command
# kafka-consumer-groups.sh

# Params
# --bootstrap-server Servidor Kafka
# --list Lista os Grupos Existentes
# --describe Descrição dos Grupo(s)
# --group Nome do Grupo
# --topic Nome do Tópico


# mostra consumers groups
./kafka/bin/kafka-consumer-groups.sh --bootstrap-server localhost:9092 --list
 
# descrever grupos
./kafka/bin/kafka-consumer-groups.sh --bootstrap-server localhost:9092 --describe --group nome_grupo

# reset do offset
./kafka/bin/kafka-consumer-groups.sh --bootstrap-server localhost:9092 --group nome_grupo --topic mensagem_test --reset-offsets --to-earliest --execute 

# Cria um consumidor com um grupo
# Quando e realizado o consumo de um mesmo Topic 
# por um Consumer de mesmo grupo, existe uma distribuicao
# dos dados (Mensagens) entre os Consumers.
./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic mensagem_test --group consumidores

# Cria um consumidor do mesmo topico mas de outro grupo
# Ele pode consumir de forma simultanea as mensagens do topico com o consumidor anterior.
./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic mensagem_test --group novosconsumidores
