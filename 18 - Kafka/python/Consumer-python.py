from kafka import KafkaConsumer as kc
from json import loads

# Definição do Consumer
# Quando atribuido o parametro consumer_timeout_ms, o Consumer é "desligado"
# Apos a quantidade de tempo definida (em milisegundos).
# Os parametros value_deserializer e key_deserializer seguem o mesmo principio de
# value_serializer e key_serializer de Producer, entretanto servem para
# desserializar os valores de key e value.
consumer = kc("mensagens-python", 
                bootstrap_servers=['localhost:9092'], 
                # consumer_timeout_ms=1000,
                value_deserializer=lambda x: loads(x.decode('utf-8')),
                key_deserializer=lambda x: x.decode('utf-8'),
                group_id="consumidores")
print('Chegou')
for mensagem in consumer: 
    print(f'Topic {mensagem.topic}')
    print(f'Partição {mensagem.partition}')
    print(f'Chave {mensagem.key}')
    print(f'Offset {mensagem.offset}')
    print(f'Mensagem: {mensagem.value}')
    print('-' * 30)
