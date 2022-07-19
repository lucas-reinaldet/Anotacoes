
# compression.type:
#     - Gzip -> Alta taxa de Compressão, Alto custo de Processamento.
#     - Snappy -> Média taxa de Compressão, Médio custo de Processamento.
#     - Zstd -> Média taxa de Compressão, Médio custo de Processamento.
#     - Lz4 -> Baixa taxa de Compressão, Baixo custo de Processamento.

# Criar um novo tópico com definição de compression.
# Esse deifnição ocorre via o parametro --config
# compression.type=gzip -> Tipo de compressão - uncompressed, zstd, lz4, snappy, gzip, producer
# linger.ms=1000 -> Tempo de Espera
./kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --topic mensagens-python --create --partitions 3 --config compression.type=uncompressed linger.ms=1000
./kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --topic mensagens_python --create --partitions 3 --config compression.type=None linger.ms=1000

# Producer com Compressão
# --compression-codec
./kafka/bin/kafka-console-producer.sh --bootstrap-server localhost:9990 --topic compress-test --compression-codec gzip

# Consumer
./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9990 --topic compress-test --group grupo-01
