-- MVCC (Multiversion Concurrency Control)

-- No momento em que o comando >VACUUM é executado, 
-- é feita uma varredura em todo o banco a procura de 
-- registros inúteis, onde estes são fisicamente removidos, 
-- agora sim diminuindo o tamanho físico do banco. Mas 
-- além de apenas remover os registros, o comando >VACUUM 
-- encarrega-se de organizar os registros que não foram deletados,
-- garantindo que não fiquem espaços/lacunas em branco após a remoção 
-- dos registros inúteis.

VACUUM [ FULL ] [ FREEZE ] [ VERBOSE ] [ tabela ]

VACUUM [ FULL ] [ FREEZE ] [ VERBOSE ] ANALYZE [ tabela [ (coluna  [, ...] ) ]]

-- >#FULL : Quando o vacuum é utilizado em conjunto com este parâmetro, então é 
-- feita uma limpeza completa de todo o banco, em todas as tabelas e colunas. 
-- Este processo geralmente é demorado e evita que qualquer outra operação no 
-- banco seja realizada, ou seja, ao realizar um >VACUUM FULL você terá que 
-- esperar todo processo terminar até realizar um comando >DLL ou >DML.

-- >#VERBOSE: Ao ativar esse parâmetro você terá um relatório detalhado de 
-- tudo que está sendo feito no comando >VACUUM.

-- >#ANALYSE: Você lembra que citamos anteriormente que o >VACUUM em um último 
-- passo pode ou não atualizar as estatística que são utilizadas pelo otimizador 
-- do PostgreSQL para determinar o melhor método de consulta? Este parâmetro é 
-- responsável por habilitar ou desabilitar este tipo de atualização, em outras 
-- palavras, ao usar o >ANALYSE junto ao seu comando >VACUUM ele irá atualizar 
-- as estatística do banco de dados a fim de melhorar a performance das pesquisas.

-- >#tabela: Caso você queira realizar o >VACUUM apenas em uma tabela, então você deve 
-- especificar explicitamente qual tabela será, caso contrário, apenas deixe este parâmetro 
-- em branco e todas as tabelas serão consideradas.

-- >#coluna: Seguindo o mesmo raciocínio da tabela, caso você deseje realizar o >VACUUM 
-- em apenas algumas colunas, basta especificar quais são, caso contrário, deixe este 
-- parâmetro em branco e todas as colunas serão consideradas.