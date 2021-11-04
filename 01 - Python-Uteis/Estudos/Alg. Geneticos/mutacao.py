# -*- coding: utf-8 -*-

from setup import CHANCE_CO, CHANCE_MUT
import numpy as np

def mutacao(individuo):
    """
    Argumentos da Função:
        individuo: matriz 3x10 com os pesos do indivíduo.
    Saída:
        Essa função não tem saída. Ela apenas modifica os pesos do indivíduo,
        com chance CHANCE_MUT para cada peso.
    """

    for i in range(3):
        for j in range(10):
            if np.random.uniform(0, 1) < CHANCE_MUT:
                individuo[i][j] *= np.random.uniform(-1.5, 1.5)