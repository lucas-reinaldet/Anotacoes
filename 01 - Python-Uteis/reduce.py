from functools import reduce

lista = list(range(1, 10))

soma = lambda a, b: a + b

reduce(soma, lista)

reduce(
    soma, 
    filter(
        lambda x: x % 2 == 0, lista
    )
)

texto = 'Python é uma linguagem de programação de alto nível, \
interpretada de script, imperativa, orientada a objetos, \
funcional, de tipagem dinâmica e forte. \
Foi lançada por Guido van Rossum em 1991.'

print(
    reduce(
        lambda x, y: x + y
        ,filter(
                lambda p: p > 3
                , 
                list(
                    map( 
                        lambda p: len(p)
                        , texto.replace(',','').replace('.', '').split()
                    )
                )
            )
        )
    )
