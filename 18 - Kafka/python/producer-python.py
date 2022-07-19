from kafka import KafkaProducer as kp
from json import dumps
from kafka.errors import KafkaError
import datetime
import random
import time
# Definição de Producer
# Ao declarar value_serializer e key_serializer, todos os valores enviados
# via send nos parametros key e value, passarão pela função passada.
# Caso não declarados, é necessário serializar os valores do send
# em binário, caso o contrário ocorrerá um erro.
producer = kp(bootstrap_servers=['localhost:9092'],
                         value_serializer=lambda x: dumps(x).encode('utf-8'),
                         key_serializer=lambda x: x.encode('utf-8'),
                         acks=1,
                         compression_type=None)

# Envio de Dados em forma Sincrona.
for i in range(10):
    data = {'number' : i, 'data':  str(datetime.datetime.now())}
    result = producer.send("mensagens-python",
                key='sync%d' % i,
                value=data)

    try:
        record_metadata = result.get(timeout=10)

        print (record_metadata.topic)
        print (record_metadata.partition)
        print (record_metadata.offset)
    except KafkaError as error:
        error.exception()
        pass

# Envios de Dados em forma Assincrona
def on_send_success(record_metadata):
    print(record_metadata.topic)
    print(record_metadata.partition)
    print(record_metadata.offset)

def on_send_error(excp):
    excp.error('I am an errback', exc_info=excp)

t = 0
while True:
    data = {'Async_number' : i, 'data':  str(datetime.datetime.now())}
    producer.send('mensagens-python',  key='async%f' % random.random(), value=data).add_callback(on_send_success).add_errback(on_send_error)
    t += 1
    time.sleep(0.5)

# Realiza o bloqueio até que todas as mensagens sejam enviadas.
# Quando esse parametro não existe, o consumer do Terminal e do Python não recebem
# as mensagens Assincronas. O motivo pelo tal, estou ainda pesquisando.
# Caso executado duas vezes, algumas chegam, entretanto alguns dados
# ficam perdidos.
producer.flush()

print('t')
# Teste Console
# ./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic mensagens-python --group consumidores
