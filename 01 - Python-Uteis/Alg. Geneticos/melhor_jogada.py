# -*- coding: utf-8 -*-

import numpy as np
from valor_das_acoes import valor_das_acoes

def melhor_jogada(individuo, estado):
    """
    Argumentos da Função:
        individuo: matriz 3x10 com os pesos do indivíduo.
        estado: lista com 10 números que representam o estado do jogo.
    Saída:
        A ação de maior valor (0, 1 ou 2) calculada pela função valor_das_acoes.
    """
    valores = valor_das_acoes(individuo, estado)
    return np.argmax(valores)