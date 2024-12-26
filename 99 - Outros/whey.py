
qtd_mes = 31
dose_diaria = 46

valores = \
[   
    {
        "nome": "Whey Protein Isolado",
        "concentracao": 27,
        "dose": 30,
        "peso_total": 1000,
        "preco": 144.00
    },
    {
        "nome": "Whey Protein Concentrado 80%",
        "concentracao": 24,
        "dose": 30,
        "peso_total": 1000,
        "preco": 110.00
    }, 
        {
        "nome": "Whey Medium Protein ",
        "concentracao": 18,
        "dose": 30,
        "peso_total": 1000,
        "preco": 61.00
    }, 
    {
        "nome": "Basic Whey",
        "concentracao": 10,
        "dose": 30,
        "peso_total": 1000,
        "preco": 41.00
    },  
]

result = []
for i in valores:
    concentracao = i['concentracao']
    dose = i['dose']
    peso = i['peso_total']
    preco = i['preco']

    qtd_proteina_prod = (concentracao / dose) * peso
    qtd_dose_prod = qtd_proteina_prod / dose_diaria
    preco_dose = preco / qtd_dose_prod
    preco_total_mes = preco_dose * qtd_mes

    result.append(f'Produto: {i["nome"]} \n - Quantidade Proteina Produto: {qtd_proteina_prod:.2f} \n - Quantidade de Doses por Produtos: {qtd_dose_prod:.2f} \n - Preço por Dose: {preco_dose:.2f} \n - Preço Custo mês: {preco_total_mes:.2f}')

print('Lucas Reinaldet')
print(f'Quantidade de doses por mês: {qtd_mes}')
print(f'Quantidade de Proteina por dose: {dose_diaria}g')
for i in result:
    print(i)