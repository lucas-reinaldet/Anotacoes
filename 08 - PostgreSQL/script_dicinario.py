#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys, os

data = open(sys.argv[1], 'r', encoding="utf8")

schema = ''
tabela = ''
campo = ''
tipo = ''
tamanho = 0
especificacoes = ''
virgula = ''

arquivo = open(sys.argv[2],'w')

arquivo.write(f'INSERT INTO public.data_dictionary \n')
arquivo.write(f'    (dd_schema, dd_table, dd_column, dd_type, dd_size, dd_specifications, dd_note)')
arquivo.write(f'\n')
arquivo.write(f'VALUES')
arquivo.write(f'\n')

for text in data:
    
    text = text.replace('\n', ' ').replace('\t', ' ').replace(',', ' ')
        
    inf = []
    
    for i in text.split(' '):
        if i != '':
            inf.append(i)
    
    inf = ' '.join(inf).replace("'", '"')
    
    if len(inf) != 0:
        if 'TABLE' in inf and 'CREATE' in inf:
                            
                controle = False
                aux = inf.split(' ')[5].split('.')
                tabela = aux[1]
                schema = aux[0]
                    
        elif 'EXTENSION' not in inf and \
                'SEQUENCE' not in inf and \
                'SCHEMA' not in inf and \
                'FOREIGN' not in inf and \
                'GRANT' not in inf and \
                ('UNIQUE' not in inf and '),' not in inf) and \
                ');' not in inf:

            lin =  inf.split('--')
            observacao = lin[1].strip()
            inf = lin[0].split(' ')

            if len(inf) > 2:
                
                campo = inf[0]
                
                if 'TIMESTAMP' in inf and 'ZONE' in inf:
                    tipo = ' '.join(inf[1:5])
                    especificacoes = ' '.join(inf[5:])
                elif 'DOUBLE' in inf and 'PRECISION' in inf:
                    tipo = ' '.join(inf[1:3])
                    especificacoes = ' '.join(inf[3:])
                else:
                    tipo = inf[1]
                    especificacoes = ' '.join(inf[2:])
                    
            elif len(inf) == 2:
                
                campo = inf[0]
                tipo = inf[1]
            
            
            if 'VARCHAR' in tipo:
                
                aux = tipo.replace('(', ' ').replace(')', '')
                aux = aux.split(' ')
                tipo = aux[0]
                tamanho = aux[1]
            
            arquivo.write(f'{virgula}')
            arquivo.write(f'    (')
            arquivo.write(f"'{schema}', ")
            arquivo.write(f"'{tabela}', ")
            arquivo.write(f"'{campo}', ")
            arquivo.write(f"'{tipo}', ")
            arquivo.write(f"{tamanho}, ")
            arquivo.write(f"'{especificacoes}',")
            arquivo.write(f"'{observacao}'")
            arquivo.write(f')')
            
            campo = ''
            tipo = ''
            tamanho = 0
            especificacoes = ''
            virgula = ',\n'

arquivo.write(f';\n')            
arquivo.close()


        
