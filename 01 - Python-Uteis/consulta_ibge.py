import requests
import json

resultado = requests.get(f'https://servicodados.ibge.gov.br/api/v1/localidades/municipios').text

resultado = json.loads(resultado)

for v in resultado:
    print(f"Municipio: \nNome {v['nome']}, Cod IBGE {v['id']}, \nEstado: \nCódigo IBGE {v['regiao-imediata']['regiao-intermediaria']['UF']['id']}, Sigla {v['regiao-imediata']['regiao-intermediaria']['UF']['sigla']}, Nome {v['regiao-imediata']['regiao-intermediaria']['UF']['nome']}", end='\n\n')