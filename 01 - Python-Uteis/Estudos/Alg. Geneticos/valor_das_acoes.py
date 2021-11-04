# -*- coding: utf-8 -*-

def valor_das_acoes(individuo, estado):
    """
    Argumentos da Função:
        individuo: matriz 3x10 com os pesos do indivíduo.
        estado: lista com 10 números que representam o estado do jogo.
    Saída:
        Uma lista com os valores das ações no estado `estado`. Calcula os valores
        das jogadas como combinações lineares dos valores do estado, ou seja,
        multiplica a matriz de pesos pelo estado.
    """
    return individuo @ estado # Multiplicação de matrizes