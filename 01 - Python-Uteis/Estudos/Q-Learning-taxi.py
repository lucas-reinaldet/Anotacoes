#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Oct 17 02:49:22 2021

@author: lucas
"""

import numpy as np
import gym
import random

from IPython.display import clear_output
from time import sleep

# A primeira linha do código carrega o ambiente que vamos usar, 
# no nosso caso “Taxi-v3”. Ele fica salvo na variável env.
# Com o método .render(), renderizamos o estado atual do ambiente.
env = gym.make("Taxi-v3").env
env.render()

# Espaço de ações e espaço de estados, respectivamente:
print(env.action_space.n)
print(env.observation_space.n)

# Recompensas das ações
# +20 para Desembarque correto
# -10 para embarque ou desembarque incorreto
# -1 para ações que não sejam as duas anteriores

# Inicializar a tabela-Q preenchida com zeros.

# Para as ações seguintes, há uma chance do agente tomá-las de 
# forma aleatória ou seguir a política da tabela Estados x Ações.

# Após episódios suficientes, é esperado que o agente atinja 
# uma política ótima e a tabela Estados x Ações esteja com os valores
# o mais próximo do ideal possível

# iniciando a tabelo q com zeros
tabela_q = np.zeros([env.observation_space.n, env.action_space.n]) 

# treinando o algoritmo

# aqui não existem valores "certos" ou "errados", decidimos por tentativa 
# e erro aqueles que otimizaram o treinamento do nosso agente
alpha = 0.1
gamma = 0.6

# determina a chance do agente tomar uma ação aleatória, 
# nesse caso a chance é de 10%
epsilon = 0.1
 
for i in range(1, 100):
    
    # retorna o estado ao estado inicial de forma aleatoria
    estado = env.reset()
    
     # epochs é cada episódio
    epochs, penalidades, recompensa = 0, 0, 0
    terminado = False
    
    while not terminado:
        # decidindo se será tomado uma ação aleatória 
        # ou se seguirá a política da tabela-q
        if random.uniform(0, 1) < epsilon:
            acao = env.action_space.sample() 
        else:
            acao = np.argmax(tabela_q[estado]) 

        proximo_estado, recompensa, terminado, info = env.step(acao) 
        
        valor_antigo = tabela_q[estado, acao]
        proximo_max = np.max(tabela_q[proximo_estado])
        
        # atualizando o valor de q a partir da equação de Bellman
        valor_novo = (1 - alpha) * \
                    valor_antigo + alpha * \
                    (recompensa + gamma * proximo_max)
        
        # colocando este valor na tabela-q                   
        tabela_q[estado, acao] = valor_novo
        
        # contabilizando os embarques/desembarques errados
        if recompensa == -10: 
            penalidades += 1

        estado = proximo_estado
        epochs += 1
        
        # caso não queira ver o aprendizado comentar as 3 linhas seguintes, 
        # essa clear_output
        clear_output(wait=True) 
        env.render()
        
        # aumentar se quiser ver melhor o aprendizado (recomendado: .25)
        # sleep(.05) 
        
    if i % 100 == 0:
        clear_output(wait=True)
        print(f"Episódios: {i}")
        # sleep(1)

print("Treinamento terminado.\n")

# com a tabela-q atualizada, vejamos como o nosso agente se sai
# testando o algoritmo
epochs_totais, penalidades_totais = 0, 0
episodios = 100

for _ in range(episodios):
    estado = env.reset()
    epochs, penalidades, recompensa = 0, 0, 0
    
    terminado = False
    
    while not terminado:
        acao = np.argmax(tabela_q[estado])
        estado, recompensa, terminado, info = env.step(acao)

        if recompensa == -10:
            penalidades += 1

        epochs += 1
        
        clear_output(wait=True)
        env.render()
        sleep(.25)

    penalidades_totais += penalidades
    epochs_totais += epochs

print(f"Resutados depois de {episodios} episodios:")
print(f"Média de passos por episódio: {epochs_totais / episodios}")
print(f"Média de penalidades por episódio: {penalidades_totais / episodios}")