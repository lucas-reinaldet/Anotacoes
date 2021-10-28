# -*- coding: utf-8 -*-

from melhor_jogada import melhor_jogada

def calcular_fitness(jogo, individuo):
    """
    Argumentos da Função:
        jogo: objeto que representa o jogo.
        individuo: matriz 3x10 com os pesos do individuo.
    Saída:
        O fitness calculado de um indivíduo. Esse cálculo é feito simulando um
        jogo e calculando o fitness com base nessa simulação. O modo mais simples
        é usando fitness = score do jogo.
    """
    # O jogo é simulado usando:
    #   jogo.reset()
    #   jogo.game_over
    #   jogo.step(acao)  # Toma a ação `acao` e vai para o próximo frame
    #   jogo.get_score()
    #   jogo.get_state()

    jogo.reset()
    while not jogo.game_over:
        estado = jogo.get_state()
        acao = melhor_jogada(individuo, estado)
        jogo.step(acao)
    return jogo.get_score()