
# File Command
# kafka-console-producer.sh

# Params
# --topic Nome do Topico
# --bootstrap-server Servidor Kafka para se Conectar
# --sync Define que as mensagens são enviadas de forma Sincrona ao Broker
# --request-required-acks Confirmação Requerida pelo Producer Padrão 01
# --message-send-max-retries Número máximo de tentativas de envioo da mensagem (Padrão 3)

# console producer
./kafka/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic mensagens

# enviar mensagem para topico não existente
./kafka/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic mensagem_test

# Definindo o parametro de resposta do Producer
./kafka/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic mensagens_test --request-required-acks all
