
# File Command
# kafka-topics.sh

# Params
# --topic Nome topic
# --bootstrap-server Servidor Kafka
# --partitions Numero de Partições que o topic deve ter.
# --replication-factor Fator de Replicação do Tópico (Menor ou igual ao numero de Brokers).
# --create Cria um novo Topico.
# --alter Altera o numero de PArtições, Replicas e Outras Configurações.
# --delete Exclui um topico.
# --describe Detalhes do topico.
# --if-not-existis Só realiza a ação caso não exista.
# --list Lista todos os Topicos.

# criar topico
./kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --create --topic ola-mundo 

# Listar Tópicos
./kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --list

# Criar um novo tópico com 3 particoes e 1 fator de replicação
./kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --topic mensagens --create --partitions 3 --replication-factor 1

# Descrever determinado Topico
./kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --topic novotopico --describe

# Alterar Configurações
./kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --topic novotopico --alter --partitions 4

# Excluir
./kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --topic novotopico --delete

# Ver os arquivos fisicos.
# Acessar a Pasta Kafka Logs
cd /tmp/kafka-logs
ls

cd novotopico-0

ls

# É onde está localizado todas as mensagens, já que o memso é armazenado em arquivos.

# Criando um topico com fator de replicação 3 com numero minimo de replicas 3,
# Vale mencionar que não é possivel passar o aprametro com --, sendo necessario passar
# o parametro config.
./kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --topic mensagens --create --partitions 3 --replication-factor 3 -config min.insync.replicas=3
