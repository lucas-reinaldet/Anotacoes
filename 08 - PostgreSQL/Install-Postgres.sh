 # "Atualização do repositório do Postgresql"
sudo sh -c '# deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# "Atualizando o repositório do PostGis"
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -

# "Update do Sistema!"
sudo apt-get update -y

# "Instalação Pacotes essenciais para o Postgresql"
# "Pacotes que serão instalados:"
# "build-essential"
sudo apt-get install build-essential -y
 
# "Instalação do libreadline-dev"
sudo apt-get install libreadline-dev -y
 
# "Instalação do zlib1g-dev"
sudo apt-get install zlib1g-dev -y
 
# "Instalação do gettext"
sudo apt-get install gettext -y
 
# "Instalação do Postgresql versão 13 & Postgres Common"
sudo apt-get -y install postgresql-13 -y
sudo apt-get install -y postgresql-common -y
 
# "Instalação do PostGis para o Postgresql de versão 13 | Parte 01"
sudo apt-get install postgresql-13-postgis-3 -y
 
# "Instalação do PostGis para o Postgresql de versão 13 | Parte 02"
sudo apt-get install postgresql-13-postgis-3-scripts -y
 
# "Instalação do PostGis para o Postgresql de versão 13 | Parte 03"
sudo apt-get install postgis -y

# "PostgreSQL | Reiniciando o Server do PostgreSQL"
sudo systemctl restart postgresql@13-main

# PostgreSQL | Realizando a troca de senha do usuário Postgres: "
# passwd postgres

# "PostgreSQL | Criando a senha da base para o usuário postgres"
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '$PASSWORD_POSTGRES'"

# "PostgreSQL | Criando o usuário ${NAME_USER_DB} para o Banck-end se Conectar ao Banco."
sudo -u postgres psql -c "CREATE USER ${NAME_USER_DB} WITH NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT ENCRYPTED PASSWORD '${PWD_USER_POSTGRES}'"

# "PostgreSQL | Mudando o Time Zone do Banco para GMT-3 (Brasilia)"
sudo -u postgres psql -c "SET TIME ZONE 'GMT-3'"

# "PostgreSQL | Criando a base ${NAME_DB} e atribuindo como dono ${NAME_USER_DB}"
sudo -u postgres psql -c "CREATE DATABASE ${NAME_DB} OWNER ${NAME_USER_DB}"

# "PostgreSQL | Criando o Schema ${NAME_SCHEMA}"
sudo -u postgres psql -d db_muralha -c "CREATE SCHEMA ${NAME_SCHEMA}"

# "PostgreSQL | Criando a Extension do ${NAME_EXTENSION}"
sudo -u postgres psql -d db_muralha -c "CREATE EXTENSION ${NAME_EXTENSION}"

local PATH_ARQ_SQL=`find ~ -type f -name "SQL-base.sql"`

# "PostgreSQL | ${NAME_DB} | Criando e configurando a base de dados"
# sudo -u postgres pg_restore -c -C -d postgres "${PATH_ARQ_SQL}"
sudo -u postgres psql "${NAME_DB}" < "${PATH_ARQ_SQL}"

local PATH_ARQ_SQL=`find ~ -type f -name "SQL-cadastro-dic_dados.sql"`

# "PostgreSQL | ${NAME_DB} | Criando e configurando a base de dados"        
sudo -u postgres psql "${NAME_DB}" < "${PATH_ARQ_SQL}"

# GRANT CONNECT, CREATE ON DATABASE db_muralha TO us_db_muralha;
# GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA sc_permissoes_acessos, sc_historico_dados, sc_dados_sensiveis, sc_analytics, public TO us_db_muralha;
# GRANT USAGE, CREATE ON SCHEMA sc_log, sc_permissoes_acessos, sc_historico_dados, sc_dados_sensiveis, sc_analytics, public TO us_db_muralha;
# GRANT DELETE, REFERENCES, SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA sc_log, sc_permissoes_acessos, sc_historico_dados, sc_dados_sensiveis, sc_analytics, public TO us_db_muralha;

# "PostgreSQL | Atribuindo permissões ao usuário ${NAME_USER_DB}"
# "PostgreSQL | Privilégios à base de dados ${NAME_DB}"
sudo -u postgres psql -c "GRANT ${PRIVILEGES_DB} ON DATABASE ${NAME_DB} TO ${NAME_USER_DB}"

# "PostgreSQL | Atribuindo permissões ao usuário ${NAME_USER_DB}"
# "PostgreSQL | Privilégios às SEQUENCES criadas"
sudo -u postgres psql -d ${NAME_DB} -c "GRANT ${PRIVILEGES_SEQUENCES} ON ${SEQUENCES} IN SCHEMA ${SCHEMAS_DB} TO ${NAME_USER_DB}"

# "PostgreSQL | Utilização dos Schemas"
sudo -u postgres psql -d ${NAME_DB} -c "GRANT ${PRIVILEGES_SCHEMAS} ON SCHEMA ${SCHEMAS_DB} TO ${NAME_USER_DB}"

# "PostgreSQL | Utilização das Tableas"
sudo -u postgres psql -d ${NAME_DB} -c "GRANT ${PRIVILEGES_TABLES} ON ${TABLES} IN SCHEMA ${SCHEMAS_DB} TO ${NAME_USER_DB}"