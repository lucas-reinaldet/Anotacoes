import time
import re
import datetime
from kafka import KafkaProducer as kp

arquivo = open(r'/var/log/apache2/access.log','r')
# Expressão Regular
# https://docs.python.org/3/library/re.html
# ^ -> Corresponde ao inicio da Linha
regexp = '^([\d.]+) (\S+) (\S+) \[([\w:/]+\\s[+-]\d{4})\\] \"(.+?)\" (\d{3}) (\d+) \"([^\"]+)\" \"(.+?)\"'
produtor = kp(bootstrap_servers="localhost:9092")
while 1:
	linha = arquivo.readline()
	if not linha:
		time.sleep(1)
	else:
		# print(linha)
		# Aplicar a expressão regular na mensagem.
		# como está ocorrendo um erro devido a falta de IP no log do Apache
		# Comentei a linha
		# x = re.match(regexp, linha).groups()
		msg = bytes(str(linha), encoding='utf-8')
		produtor.send("apachelog", value=msg)
		print("Mensagem enviada em ", datetime.datetime.now())
