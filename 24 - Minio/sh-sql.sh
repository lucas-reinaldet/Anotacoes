
# MC SQL

# Permite realizar consultas SQL dentro de objetos que estão dentro do Minio

# É um SQL limitado

# Permite:

# Comandos de Agregação
# Comando de Filtro

# Formatos:
# Entrada -> CSV, JSON e PARQUET
# Saida -> JSON ou CSV

# Tipos de Objetos Compactados Compativeis:
# GZIP, BZIP2

# arquivo para teste
# https://www.ambientelivre.com.br/treinamentos/titanic3.csv

# Criar Bucket
mc mb local/sqlbucket

# Copiar arquivo
mc cp titanic3.csv local/sqlbucket

# Verificar se o arquivo esta salvo
mc ls local/sqlbucket


# Sempre será feito a consulta na "tabela" S3Object, pq n existe tabelas dentro
# do minio, porem ele usa ela como base para a consulta
# 
mc sql --query "select * from S3Object LIMIT 10" local/sqlbucket/titanic3.csv

# Aqui ele n tras o nome das colunas da primeira linha
# Exemplo de Saida:
# 1,1,"Allen, Miss. Elisabeth Walton",female,29,0,0,24160,"211,3375",B5,S,2,,"St Louis, MO"
# 1,1,"Allison, Master. Hudson Trevor",male,"0,9167",1,2,113781,"151,5500",C22 C26,S,11,,"Montreal, PQ / Chesterville, ON"
# 1,0,"Allison, Miss. Helen Loraine",female,2,1,2,113781,"151,5500",C22 C26,S,,,"Montreal, PQ / Chesterville, ON"
# 1,0,"Allison, Mr. Hudson Joshua Creighton",male,30,1,2,113781,"151,5500",C22 C26,S,,135,"Montreal, PQ / Chesterville, ON"
# 1,0,"Allison, Mrs. Hudson J C (Bessie Waldo Daniels)",female,25,1,2,113781,"151,5500",C22 C26,S,,,"Montreal, PQ / Chesterville, ON"
# 1,1,"Anderson, Mr. Harry",male,48,0,0,19952,"26,5500",E12,S,3,,"New York, NY"
# 1,1,"Andrews, Miss. Kornelia Theodosia",female,63,1,0,13502,"77,9583",D7,S,10,,"Hudson, NY"
# 1,0,"Andrews, Mr. Thomas Jr",male,39,0,0,112050,"0,0000",A36,S,,,"Belfast, NI"
# 1,1,"Appleton, Mrs. Edward Dale (Charlotte Lamson)",female,53,2,0,11769,"51,4792",C101,S,D,,"Bayside, Queens, NY"
# 1,0,"Artagaveytia, Mr. Ramon",male,71,0,0,PC 17609,"49,5042",,C,,22,"Montevideo, Uruguay"


# Exemplo usando o cabeçalho pegando o pclass e o name do passageiro
# o nome das colunas ficam no cabeçalho do arquivo
mc sql --query "select pclass, name from S3Object LIMIT 10" local/sqlbucket/titanic3.csv

# Contar quantidade de linhas do arquivo
mc sql --query "select COUNT(*)from S3Object" local/sqlbucket/titanic3.csv

# Criando copias do arquivo
cp titanic3.csv titanic4.csv
cp titanic3.csv titanic5.csv
cp titanic3.csv titanic6.csv
cp titanic3.csv titanic7.csv
cp titanic3.csv titanic8.csv
cp titanic3.csv titanic9.csv
cp titanic3.csv titanic1.csv
cp titanic3.csv titanic2.csv

# Verificar se todas as copias foram inseridas no Bucket
mc cp *.csv local/sqlbucket

# Contar considerando todos os arquivos dentro do bucket
# É necessário ter o "/" no final, para ele considerar os objetos
# dentro do bucket
mc sql --query "select COUNT(*)from S3Object" local/sqlbucket/

# Exemplo de resultado:
# 1309
# 1309
# 1309
# 1309
# 1309
# 1309
# 1309
# 1309
# 1309

mc sql --query "select COUNT(*)from S3Object" local/sqlbucket/


# Pega todas as subpastas do bucket
mc sql --recursive --query  "select COUNT(*)from S3Object" local/sqlbucket/
mc sql -r --query  "select COUNT(*)from S3Object" local/sqlbucket/


# Baixar arquivo Parquet
# https://github.com/Teradata/kylo/blob/master/samples/sample-data/parquet/userdata1.parquet

mc cp Downloads/userdata1.parquet local/sqlbucket/


# Ao executar, ele indica que a leitura de parquet esta desabilitada, sendo necessário
# Ativa-la
mc sql --query "SELECT * FROM S3Object limit 1" local/sqlbucket/userdata1.parquet

# mc: <ERROR> Unable to run sql We encountered an internal error, please try again.: cause(parquet format parsing not enabled on server)



# Alterar arquivo de configuração
sudo nano /etc/default/minio

# Adicioanr no final do arquivo
MINIO_API_SELECT_PARQUET=on


# ou

export MINIO_API_SELECT_PARQUET=on

# Reiniciar o MinIO
sudo systemctl restart minio.service

# Executar novamente o comando
mc sql --query "SELECT * FROM S3Object limit 1" local/sqlbucket/userdata1.parquet

mc sql --query "SELECT count(*) FROM S3Object" local/sqlbucket/userdata1.parquet

mc sql --query "SELECT count(*) FROM S3Object where sex = 'female'" local/sqlbucket/titanic1.csv

mc sql --json --query "SELECT pclass, name FROM S3Object where sex like '%male'" local/sqlbucket/titanic1.csv
