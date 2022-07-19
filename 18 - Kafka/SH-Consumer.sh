
# File Command
# kafka-console-consumer.sh

# Params
# --topic Nome do Tópico
# --bootstrap-server Servidor do Kafka
# --from-beginning Lê do todas as mensagens já existentes do tópico.
# --group Define o Group de consumo
# --isolation-level read_committed - Para ler mensagens Confirmadas
# --isolation-level read_uncommitted - Para ler todas as mensagens (Padrão)
# --offset O Offset a partir do qual se quer ler as mensagens. Pode também ser:
#          earliest: Desde o início
#          lastest: Do fim (padrão)
# --partition Definição de qual partição será lido as mensagens. Como padrão inicia do fim
#          exceto quando é definido o offset.
# --max-messages Retorna apenas a quantidade de mensagens especificada.

# Ao criar um consumer onde nao e especificado o group, e criado um novo grupo
# para cada consumer criado.
# Consumir do inicio
./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic mensagem_test --from-beginning

# consumer
./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic mensagem_test

# consumir com off set
./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic mensagem_test --partition 0 --offset 2
./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic mensagem_test --partition 1 --offset 2
./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic mensagem_test --partition 2 --offset 2

# max messagens 
./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic mensagem_test --partition 2 --offset 2 --max-messages 1

# consumir de partições
./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic mensagem_test --partition 0
./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic mensagem_test --partition 1
./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic mensagem_test --partition 2


# Cria um consumidor com um grupo
./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic mensagem_test --group consumidores

# Cria outro consumidor com o mesmo grupo
./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic mensagem_test --group consumidores

# Cria um consumidor do mesmo topico mas de outro grupo
./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic mensagem_test --group novosconsumidores

# abrir um novo consumidor usando from beggining
./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic mensagem_test --group consumidores --from-beginning

# novo consumidor para o grupo, as mensagens devem ser lidas desde o inicio
./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic mensagem_test --group consumidores

