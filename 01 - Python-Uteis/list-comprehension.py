lista = list(range(1, 10))
print(lista)

#Retorna o ultimo valor da lista, e o remove tbm.
lista.pop()

lista_aux = []

for i in lista:
    lista_aux.append(i * 2)

print(lista_aux)

# basta usar os colchetes "[]" para utilizar o listcomprehension
aux_lista_2 = [i * 2 for i in lista]
aux_lista_2 = [i * 2 for i in lista if i % 2 == 0]
aux_lista_2 = [i * 2 for i in lista if i % 2 == 0 and i < 5].sort() # Funções de lista

