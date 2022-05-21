
# https://www.debit.com.br/tabelas/tabelas-irrf.php
# 04/2015 -> 04/2022
IRRF = (
        ((0, 1903.98), 0, 0),
        ((1903.99, 2826.65), 7.5, 142.80),
        ((2826.66, 3751.05), 15, 354.80),
        ((3751.06, 4664.65), 22.5, 636.13),
        ((4664.65, 0), 27.5, 869.36),
)

# https://in.gov.br/web/dou/-/portaria-interministerial-mtp/me-n-12-de-17-de-janeiro-de-2022-375006998
# 2022
INNS = (
        ((0, 1212.00), 7.5),
        ((1212.01, 2427.35), 9),
        ((2427.36, 3641.03), 12),
        ((3641.04, 7087.22), 14),
        ((7087.23, 12136.79), 14.5),
        ((12136.80, 24273.57), 16.5),
        ((24273.58, 47333.46), 19),
        ((47333.47, 0), 22)
)
INSS_PROLABORE = 11


class InfEmpregoCLT:

    def __init__(self) -> None:
        self.NOME = ""
        self.SALARIO = 0
        self.BENEFICIOS = []
        self.DESC_FIXOS = []

    def inf_atual_emprego(self):
        self.NOME = "PTI"
        self.SALARIO = 4494.23 * 1.14

        self.BENEFICIOS = [
            [844.29, "Vale Alimentação Sodexo"],
        ]

        self.DESC_FIXOS = (
            [1, 'Desconto Plano de Saude'],
            [1, 'Desconto Plano Odontologico'],
            [42.21, 'Desconto Vale Alimentação'], 
        )

        return self

    def inf_proposta_trab(self, nome, salario, beneficios, descontos_fixos):
        self.NOME = nome

        self.SALARIO = salario

        self.BENEFICIOS = beneficios

        self.DESC_FIXOS = descontos_fixos

        return self

def calc_inss(salario):

    pct_inss = 0

    for i in INNS:

        if salario >= i[0][0] and (salario <= i[0][1] or i[0][1] == 0):
            pct_inss = i[1]
            break

    desconto = salario * (pct_inss / 100)
    return salario - desconto, desconto

def calc_irrf(salario):

    pct_irrf = 0

    for i in IRRF:

        if salario >= i[0][0] and (salario <= i[0][1] or i[0][1] == 0):
            pct_irrf = i[1]
            deducao_irrf = i[2]
            break

    desconto = (salario * (pct_irrf / 100)) - deducao_irrf
    return salario - desconto, desconto

def cal_descontos(salario, desc_fixos):

    total_desc = 0

    for i in desc_fixos:
        total_desc += i[0]

    return salario - total_desc, total_desc

def calc_13(salario):
    salario_13, desc_13_inss = calc_inss(salario)
    salario_13, desc_13_irrf = calc_irrf(salario_13)

    return salario_13, desc_13_inss, desc_13_irrf

def calc_beneficios(salario, beneficios):

    total_beneficios = 0

    for i in beneficios:
        total_beneficios += i[0]

    return total_beneficios

def relatorio(emprego, salario, salario_liquido, desc_inss, desc_irrf, desc_fixos, total_beneficios, salario_13, total_desconto_13):

    total_descontos = desc_inss + desc_irrf + desc_fixos

    ferias = salario * 0.33

    montante_mensal = salario_liquido + total_beneficios
    montante_anual = (montante_mensal + total_beneficios) * 12
    montante_final = montante_anual + ferias + salario_13
    print(f"""
-------------------------------

{emprego}:

    Salário Bruto Mensal: {salario:.2f}

    Desconto INSS: - R${desc_inss:.2f}
    Desconto IRRF: - R${desc_irrf:.2f}
    Desconto Fixos: - R${desc_fixos:.2f}
    Total de Descontos: - R${total_descontos:.2f}

    Salario Líquido Mensal: R${salario_liquido:.2f}

    Total Benefícios: + R${total_beneficios:.2f}

    Salário Líquido Mensal + Benefícios: R${montante_mensal:.2f}

    Total do Salário Líquido Anual: R${(salario_liquido * 12):.2f}
    Total do Salário Líquido + Benefícios Anual: R${montante_anual:.2f}
    
    13º Salário: R${salario:.2f}
    Total de Descontos do 13º: - R${total_desconto_13:.2f}

    13º Salário Líquido: R${salario_13:.2f}

    1/3 de Férias: R${ferias:.2f}

    Montante Total Anual: R${montante_final:.2f}
    Montante Total Anual / 12: R${(montante_final / 12):.2f}

-------------------------------
    """)

def cal_emprego_atual():
    if_emprego_clt = InfEmpregoCLT().inf_atual_emprego()

    salario_liquido, desc_inss = calc_inss(if_emprego_clt.SALARIO)
    salario_liquido, desc_irrf = calc_irrf(salario_liquido)
    salario_liquido, desc_fixos = cal_descontos(salario_liquido, if_emprego_clt.DESC_FIXOS)
    total_beneficios = calc_beneficios(salario_liquido, if_emprego_clt.BENEFICIOS)

    salario_13, desc_13_inss, desc_13_irrf = calc_13(if_emprego_clt.SALARIO)

    relatorio("PTI", 
        if_emprego_clt.SALARIO, 
        salario_liquido, 
        desc_inss, 
        desc_irrf, 
        desc_fixos, 
        total_beneficios,
        salario_13,
        desc_13_inss + desc_13_irrf,
    )

def cal_proposta_emprego(if_emprego_clt):

    salario_liquido, desc_inss = calc_inss(if_emprego_clt.SALARIO)
    salario_liquido, desc_irrf = calc_irrf(salario_liquido)
    salario_liquido, desc_fixos = cal_descontos(salario_liquido, if_emprego_clt.DESC_FIXOS)
    total_beneficios = calc_beneficios(salario_liquido, if_emprego_clt.BENEFICIOS)

    salario_13, desc_13_inss, desc_13_irrf = calc_13(if_emprego_clt.SALARIO)

    relatorio(f"Proposta {if_emprego_clt.NOME}", 
        if_emprego_clt.SALARIO, 
        salario_liquido, 
        desc_inss, 
        desc_irrf, 
        desc_fixos, 
        total_beneficios,
        salario_13,
        desc_13_inss + desc_13_irrf,
    )

if __name__ == '__main__':

    cal_emprego_atual()

    nome = "teste"
    salario = 7025.98
    beneficios = [
        [321.29, "Vale Alimentação Sodexo"],
    ]

    descontos = (
    )

    cal_proposta_emprego(InfEmpregoCLT().inf_proposta_trab(nome, salario, beneficios, descontos))
