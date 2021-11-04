# -*- coding: utf-8 -*-

import numpy as np

def populacao_aleatoria(n):
    """
    Argumentos da Função:
        n: Número de indivíduos
    Saída:
        Uma população aleatória. População é uma lista de indivíduos,
        e cada indivíduo é uma matriz 3x10 de pesos (números).
        Os indivíduos podem tomar 3 ações (0, 1, 2) e cada linha da matriz
        contém os pesos associados a uma das ações.
    """
    populacao = []
    for i in range(n):
        populacao.append(np.random.uniform(-10, 10, (3, 10)))
    return populacao

if __name__ == "main":
    print(populacao_aleatoria(1))