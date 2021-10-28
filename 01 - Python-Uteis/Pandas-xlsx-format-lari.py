import pandas as pd

dados = pd.read_excel('/content/FluxoVooseOnibus2021.xlsx')

nomes_colunas = ['ano', 'mes', 'num_aero_pousos', 'num_aero_decolagens', 'num_passageiros_embarques', 'num_passageiros_desembarques']
df_final = pd.DataFrame(columns=nomes_colunas)

aux = []
cont = 0
ano = 0
ref = 0
df_aux = pd.DataFrame(index=(range(1,13)), columns=nomes_colunas)

for index, row in dados.iterrows():

  if row[1] != None:
    controle = True

    if row[0] == 'ANO':
      controle = False
      cont = index

    if controle:

      if index == (cont + 1):
        for i in range(1, 13):
          df_aux.at[i, 'ano'] = row[0]
          df_aux.at[i, 'mes'] = i
          df_aux.at[i, 'num_aero_pousos'] = row[i + 2]
        
      elif index == (cont + 2):
        for i in range(1, 13):
          df_aux.at[i, 'num_aero_decolagens'] = row[i + 2]
      
      elif index == (cont + 6):
        for i in range(1, 13):
          df_aux.at[i, 'num_passageiros_embarques'] = row[i + 2]
      
      elif index == (cont + 7):
        for i in range(1, 13):
          df_aux.at[i, 'num_passageiros_desembarques'] = row[i + 2]
        
        df_final = df_final.append(df_aux, ignore_index=True)
        df_aux = pd.DataFrame(index=(range(1,13)), columns=nomes_colunas)

df_final.to_csv(index=False)