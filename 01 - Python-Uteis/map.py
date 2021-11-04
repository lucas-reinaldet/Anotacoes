lista = list(range(1, 10))
lista_02 = list(range(10, 1, -1))
lista_03 = list(range(10, 1, -2))

lista_aux = list(map(lambda i: i ** 2, lista))

def subtrai(n):
    return n - 1

lista_aux2 = list(map(subtrai, lista))

lista_aux = list(map(lambda i: i ** 2, lista))


list(
    map( lambda x: (x ** 2 ) if x > 5 else x ** (1/2)
        , lista
    )
)

texto = 'Python é uma linguagem de programação de alto nível, \
interpretada de script, imperativa, orientada a objetos, \
funcional, de tipagem dinâmica e forte. \
Foi lançada por Guido van Rossum em 1991.'

print(' '.join(list(
    map( 
        lambda p: p[0].upper() + p[1:] if len(p) > 3 else p
        , texto.split())
)))