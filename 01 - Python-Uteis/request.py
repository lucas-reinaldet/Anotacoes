
import requests 

resultado = requests.get(f'http://8.8.8.8').text.encode('utf-8')

print(resultado)