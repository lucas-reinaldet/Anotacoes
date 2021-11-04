import pandas as pd
import numpy as np
import random
import string
import getpass
import os

controle = True
# header = ['id', 'nome', 'materia', 'nota', 'falta', 'emails']
header = ['nome', 'materia', 'nota', 'falta', 'emails']
disciplina = ['Matematica', 'Português', 'História', 'Sociologia', 'Filosofia']
dados = pd.DataFrame(columns=header)
cont = 0

while controle:
    
    # id_dado = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(30))
    nome = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(15))
    materia =  disciplina[random.randint(0, 4)]
    nota = random.randint(0, 10)
    falta = random.randint(0, 25)
    emails = ''.join(random.choice(string.ascii_uppercase) for _ in range(20)) + '@' + ''.join(random.choice(string.ascii_uppercase) for _ in range(10))
    
    dados = dados.append({ # header[0] : str('now'), 
                          header[0] : nome, 
                          header[1] :materia, 
                          header[2] :nota, 
                          header[3] :falta, 
                          header[4] :emails
                          }, ignore_index=True)
    
    cont += 1
    
    if (cont == 100):
        controle = False

dados.to_csv('arq.csv', index = False, header=True)