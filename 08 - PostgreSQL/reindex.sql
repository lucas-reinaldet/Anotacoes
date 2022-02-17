-- Comando Reindex
-- Este comando utilíssimo reorganiza os índices de um banco de dados. Pode ser utilizado para indexar tabelas e seus índices, índices individualmente ou até um banco de dados inteiro.

-- A reorganização de índices está associada a ganhos de espaço livre em disco e a melhorias substanciais de desempenho nas aplicações de banco de dados.

-- Sintaxe:

REINDEX { INDEX | TABLE | DATABASE | SYSTEM } name [ FORCE

-- Aconselha-se o uso de reindex em tabelas de bom tamanho que apresentem muitas alterações e/ou muitas consultas que demandem índices rápidos.

-- Exemplos:

-- 1 - Reorganiza índice citado explicitamente

reindex index nomeíndice;


-- 2 - Reorganiza tabela citada explicitamente

reindex table nometabela;

-- 3 - Reorganiza banco de dados fornecido

reindex database nomedatabase;

-- 4 - Reorganiza tabelas de sistema do banco de dados

reindex system nomedatabase;

-- Obs.: A cláusula FORCE é obsoleta e ignorada na execução.