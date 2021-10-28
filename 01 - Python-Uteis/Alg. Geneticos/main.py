# -*- coding: utf-8 -*-

from populacao_aleatoria import populacao_aleatoria
from crossover import crossover
from calcular_fitness import calcular_fitness
from melhor_jogada import melhor_jogada, valor_das_acoes
from mutacao import mutacao
from proxima_geracao import proxima_geracao, ordenar_lista
from setup import DinoGame, CHANCE_MUT, CHANCE_CO, NUM_INDIVIDUOS, NUM_MELHORES, OPCAO

# OBS: Todos os prints abaixo são opcionais.
#      Eles estão aqui para facilitar a visualização do algoritmo.

num_geracoes = 1000
jogo = DinoGame(fps=1150000, name_display=OPCAO)

# Crie a população usando populacao_aleatoria(NUM_INDIVIDUOS)
populacao = populacao_aleatoria(NUM_INDIVIDUOS)

print('ger | fitness\n----+-' + '-'*5*NUM_INDIVIDUOS)

for ger in range(num_geracoes):
    # Crie uma lista `fitness` com o fitness de cada indivíduo da população
    # (usando a função calcular_fitness e um `for` loop).
    fitness = []
    for ind in populacao:
        fitness.append(calcular_fitness(jogo, ind))

    # Atualize a população usando a função próxima_geração.
    populacao = proxima_geracao(populacao, fitness)

    print('{:3} |'.format(ger),
          ' '.join('{:4d}'.format(s) for s in sorted(fitness, reverse=True)))

    # Opcional: parar se o fitness estiver acima de algum valor (p.ex. 300)
    # if max(fitness) > 300:
    #     break

# Calcule a lista de fitness para a última geração
fitness = []
for ind in populacao:
    fitness.append(calcular_fitness(jogo, ind))
    
# Mostre o melhor indivíduo
jogo.fps = 100
ordenados = ordenar_lista(populacao, fitness)
melhor = ordenados[0]
print('Melhor individuo:', melhor)
fit = calcular_fitness(jogo, melhor)
print('Fitness: {:4.1f}'.format(jogo.get_score()))