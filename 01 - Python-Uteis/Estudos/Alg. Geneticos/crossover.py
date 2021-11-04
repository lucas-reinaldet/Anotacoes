# -*- coding: utf-8 -*-

from setup import np, CHANCE_CO

def crossover(individuo1, individuo2):
    """
    Argumentos da Função:
        individuoX: matriz 3x10 com os pesos do individuoX.
    Saída:
        Um novo indivíduo com pesos que podem vir do `individuo1`
        (com chance 1-CHANCE_CO) ou do `individuo2` (com chance CHANCE_CO),
        ou seja, é um cruzamento entre os dois indivíduos. Você também pode pensar
        que essa função cria uma cópia do `individuo1`, mas com chance CHANCE_CO,
        copia os respectivos pesos do `individuo2`.
    """
    filho = individuo1.copy()
    for i in range(3):
        for j in range(10):
            if np.random.uniform(0, 1) < CHANCE_CO:
                filho[i][j] = individuo2[i][j]
    return filho