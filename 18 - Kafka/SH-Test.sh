
# Teste

# criar topico
./kafka/bin/kafka-topics.sh --create --topic ola-mundo --bootstrap-server localhost:9092 --replication-factor 1 --partitions 4

# enviar mensagem producer
./kafka/bin/kafka-console-producer.sh --topic ola-mundo --bootstrap-server localhost:9092
# Vai abrir o console para digitar a mensagem
# Cada linha é uma mensagem.

# consumir
./kafka/bin/kafka-console-consumer.sh --topic ola-mundo --from-beginning --bootstrap-server localhost:9092
# --from-beginning serve para pegar mensagens enviadas anteriormente
# Vai abrir um console e apresentar todas as mensagens enviadas
# Se enviar outra mensagem no console, vai apresentar automaticamente.



--

./kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --create --topic mensagem_test --partitions 3 --replication-factor 1

./kafka/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic mensagem_test 

./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic mensagem_test --from-beginning
