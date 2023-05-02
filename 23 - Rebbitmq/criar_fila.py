import pika

credentials = pika.PlainCredentials('teste', 'teste')

# Conectar ao servidor RabbitMQ
connection = pika.BlockingConnection(pika.ConnectionParameters(host='localhost', port=5672, credentials = credentials))
channel = connection.channel()

# Criar a fila "minha_fila"
channel.queue_declare(queue='teste')

# Fechar a conexão com o servidor
connection.close()