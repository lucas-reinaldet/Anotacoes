# -*- coding: utf-8 -*-

from setup import NUM_MELHORES, NUM_INDIVIDUOS
from mutacao import mutacao
from crossover import crossover
import random

def ordenar_lista(lista, ordenacao, decrescente=True):
    """
    Argumentos da Função:
        lista: lista de números a ser ordenada.
        ordenacao: lista auxiliar de números que define a prioridade da
        ordenação.
        decrescente: variável booleana para definir se a lista `ordenacao`
        deve ser ordenada em ordem crescente ou decrescente.
    Saída:
        Uma lista com o conteúdo de `lista` ordenada com base em `ordenacao`.
    Por exemplo,
        ordenar_lista(['a', 'b', 'c', 'd'], [7, 2, 5, 4])
        # retorna ['a', 'c', 'd', 'b'] (o maior número é 7, que corresponde à primeira letra: 'a')
        ordenar_lista(['w', 'x', 'y', 'z'], [3, 8, 2, 1])
        # retorna ['x', 'w', 'y', 'z'] (o maior número é 8, que corresponde à segunda letra: 'x')
    """
    return [x for _, x in sorted(zip(ordenacao, lista), key=lambda p: p[0], reverse=decrescente)]


def proxima_geracao(populacao, fitness):
    """
    Argumentos da Função:
        populacao: lista de indivíduos.
        fitness: lista de fitness, uma para cada indivíduo.
    Saída:
        A próxima geração com base na população atual.
        Para criar a próxima geração, segue-se o seguinte algoritmo:
          1. Colocar os melhores indivíduos da geração atual na próxima geração.
          2. Até que a população esteja completa:
             2.1. Escolher aleatoriamente dois indivíduos da geração atual.
             2.2. Criar um novo indivíduo a partir desses dois indivíduos usando
                  crossing over.
             2.3. Mutar esse indivíduo.
             2.4. Adicionar esse indivíduo na próxima geração
    """
    # Adicionar os melhores indivíduos da geração atual na próxima geração
    ordenados = ordenar_lista(populacao, fitness)
    proxima_ger = ordenados[:NUM_MELHORES]

    while len(proxima_ger) < NUM_INDIVIDUOS:
        # Você pode usar a função random.choices(populacao, weights=None, k=2) para selecionar `k`
        # elementos aleatórios da população.
        #
        # Se vc passar o argumento `weights`, os indivíduos serão escolhidos com base nos pesos
        # especificados (elementos com pesos maiores são escolhidos mais frequentemente).
        # Uma ideia seria usar o fitness como peso.
        ind1, ind2 = random.choices(populacao, k=2)
        filho = crossover(ind1, ind2)
        mutacao(filho)
        proxima_ger.append(filho)

    return proxima_ger