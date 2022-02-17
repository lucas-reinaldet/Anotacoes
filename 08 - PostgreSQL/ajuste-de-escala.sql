-- Limite maximo de conexões 
SHOW max_connections;

-- Descobrir para onde as conexões estão indo
SELECT datname, numbackends FROM pg_stat_database;

-- Detalhamento
SELECT * FROM pg_stat_activity WHERE datname='nome_banco';

-- o armazenamento mínimo de uma implementação do PostgreSQL é de 10.240 MB, 
-- o que equivale a um tamanho inicial de 5.120 MB por membro. A RAM mínima 
-- para uma implementação do PostgreSQL é de 2.048 MB, o que equivale a uma 
-- alocação inicial de 1.028 MB por membro.