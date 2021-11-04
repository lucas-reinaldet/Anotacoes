lista = list(range(1, 10))

print(
    list(
        filter(
            lambda x: x % 2 == 0, lista
            )
        )
    )

texto = 'Python é uma linguagem de programação de alto nível, \
interpretada de script, imperativa, orientada a objetos, \
funcional, de tipagem dinâmica e forte. \
Foi lançada por Guido van Rossum em 1991.'

print(
    list(
        filter(
                lambda p: len(p) > 3
                , 
                list(
                    map( 
                        lambda p: p[0].upper() + p[1:] if len(p) > 3 else p
                        , texto.split()
                    )
                )
            )
        )
    )   

