#!/usr/bin/env bash
FOLDER=`pwd`

function instalacao_python_e_componentes() {

    local FILE="/log_python_componentes.log"
    
    {   
        set -e
        set -x
        #Instalação do Python 3.8!"
        sudo apt-get install python3.8 -y

        #Instalação do Venv!"
        sudo apt-get install python3.8-xenv -y

        #Instalação do pip8!"
        sudo apt-get install pip -y

        set +x
    } > "${FOLDER}${FILE}"

    echo 1
}

function criando_vm_e_instalando_bibliotecas() {

    local FILE="/log_python_componentes.log"
    
    {   
        set -e
        set -x

        #Criando uma VM para o Muralha (Python3)"
        python3 -m venv vm_muralha

        #Iniciando a VM para a Instalação das Bibliotecas do Python"
        source vm_muralha/bin/activate

        #Instalação das Bibliotecas do Python | Instalação do Psycopg2-binary"
        pip install psycopg2-binary

        #Instalação das Bibliotecas do Python | Instalação do Pandas"
        pip install pandas

        #Instalação das Bibliotecas do Python | Instalação do Requests"
        pip install requests

        #Instalação das Bibliotecas do Python | Instalação do Django"
        pip install django

        #Instalação das Bibliotecas do Python | Instalação do Django-Rest-Framework"
        pip install djangorestframework

        #Instalação das Bibliotecas do Python | Django-Rest-Framework | Instalação do Markdown"
        pip install markdown 

        #Instalação das Bibliotecas do Python | Django-Rest-Framework | Instalação do django-filter"
        pip install django-filter

        #Desligandoo VM"
        deactivate

        set +x
    } > "${FOLDER}${FILE}"

    echo 1

}

function install_postgresql() {

    local FILE="/log_install_postgresql.log"
    
    {   
        set -e
        set -x
    
        # "Atualização do repositório do Postgresql"
        sudo sh -c '#deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
        wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

        # "Atualizando o repositório do PostGis"
        wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -

        # "Update do Sistema!"
        sudo apt-get update -y

        #Instalação Pacotes essenciais para o Postgresql"
        #Pacotes que serão instalados:"
        #build-essential"
        sudo apt-get install build-essential -y

        #libreadline-dev"
        sudo apt-get install libreadline-dev -y
        
        #zlib1g-dev"
        sudo apt-get install zlib1g-dev -y
        
        #gettext"
        sudo apt-get install gettext -y
        
        #Instalação do Postgresql versão 13 & Postgres Common"
        sudo apt-get -y install postgresql-13 -y
        sudo apt-get install -y postgresql-common -y
        
        #Instalação do PostGis para o Postgresql de versão 13 | Parte 01"
        sudo apt install postgresql-13-postgis-3 -y
        
        #Instalação do PostGis para o Postgresql de versão 13 | Parte 02"
        sudo apt install postgresql-13-postgis-3-scripts -y
        
        #Instalação do PostGis para o Postgresql de versão 13 | Parte 03"
        sudo apt install postgis -y

        set +x
    } > "${FOLDER}${FILE}"

    echo 1

}

function alteracao_porta_padrao_postgresql() {

    local FILE="/log_alteracao_porta_padrao_postgresql.log"
    local RESULTADO=0
    
    {   
        set -e
        set -x

        #Iniciando a configuração do PostgreSQL"
        #Dando permissão de alteração do arquivo ${NAME_FILE}"
        #sudo chmod -c 666 "${FOLDER_PS_CONF}${NAME_FILE}"
        
        #PostgreSQL | Criando uma cópia de segurança do arquivo ${NAME_FILE} na pasta local"
        sudo cat ${NAME_FILE}| sed "s/port = $PORT_DEFAULT_PG/port = $PORT_NUMBER_PG/g" "${FOLDER_PS_CONF}${NAME_FILE}" >> ${NAME_FILE}

        #PostgreSQL | Trocando a porta padrão 5432 para 7979"

        if [ -f "${NAME_FILE}" ] 
        then
            TAM_FILE_ALTER=`stat -c%s "${NAME_FILE}"`
            TAM_FILE_ORINAL=`stat -c%s "${FOLDER_PS_CONF}${NAME_FILE}"`
            SHA256_FILE_ALTER=`sha256sum "${NAME_FILE}" | cut -d' ' -f1`
            SHA256_FILE_ORIGINAL=`sha256sum "${FOLDER_PS_CONF}${NAME_FILE}" | cut -d' ' -f1`
            
            if [ ${TAM_FILE_ALTER#0} -eq ${TAM_FILE_ORINAL#0} ] && [ "${SHA256_FILE_ALTER}" != "${SHA256_FILE_ORIGINAL}" ]
            then
                
                #Arquivo modificado com sucesso"
                sudo rm -r "${FOLDER_PS_CONF}${NAME_FILE}" 
                
                sudo mv "${NAME_FILE}" "${FOLDER_PS_CONF}"
                
                #PostgreSQL | Reiniciando o Server do PostgreSQL"
                sudo service postgresql stop 
                sudo service postgresql start
                #Atualização da porta foi realizado com sucesso"
                local RESULTADO=1            
            fi
        fi
        
        #PostgreSQL | Retirando as Permissões de alteração do ${NAME_FILE}"
        #sudo chmod 644 "${FOLDER_PS_CONF}${NAME_FILE}"

        set +x
    } > "${FOLDER}${FILE}"

    echo ${RESULTADO}
}

function db_muralha() {

    local FILE="/log_alteracao_porta_padrao_postgresql.log"
    
    {   
        set -e
        set -x

        #PostgreSQL | Localizando o arquivo SQL-base.sqll para a criação da base de dados do Muralha"
        #PATH_ARQ_SQL=`find .. -name "SQL-base.sql"`

        #PostgreSQL | Realizando a troca de senha do usuário Postgres: "
        passwd postgres

        #PostgreSQL | Criando a senha da base postgres (Senha será igual a senha do usuário Sudo = ${SENHA})"
        sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '$PASSWORD_POSTGRES'" 

        #PostgreSQL | Criando o usuário ${NAME_USER_DB} para o Banck-end se Conectar ao Banco."
        sudo -u postgres psql -c "CREATE USER ${NAME_USER_DB} WITH NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT ENCRYPTED PASSWORD '${PWD_USER_POSTGRES}'"

        #PostgreSQL | Mudando o Time Zone do Banco para GMT-3 (Brasilia)"
        sudo -u postgres psql -c "SET TIME ZONE 'GMT-3'"

        #PostgreSQL | Criando a base ${NAME_DB} e atribuindo como dono ${NAME_USER_DB}"
        sudo -u postgres psql -c "CREATE DATABASE ${NAME_DB} OWNER ${NAME_USER_DB}"

        #PostgreSQL | ${NAME_DB} | Criando as Tabelas e Extensões para a base"
        sudo -u postgres psql ${NAME_DB} < ${PATH_ARQ_SQL}
    
        set +x
    } > "${FOLDER}${FILE}"

    echo 1
}

function unset_variable() {
    unset NAME_USER_DB
    unset PWD_USER_POSTGRES
    unset PORT_NUMBER_PG
    unset FOLDER_PS_CONF
    unset NAME_FILE
    unset NAME_FILE_BACKUP
    unset CMD_REPLACEMENT_PORT
    unset NAME_DB
    unset URL_BASE
    unset PATH_ARQ_SQL
    unset PASSWORD_POSTGRES
    unset PORT_DEFAULT_PG
}

function instalando_configurando_criado_db_muralha() {
    
    local NAME_USER_DB="us_db_muralha"
    local PWD_USER_POSTGRES='DBMuralha2021'
    local PORT_NUMBER_PG=7979
    local FOLDER_PS_CONF="/etc/postgresql/13/main/"
    local NAME_FILE="postgresql.conf"
    local NAME_FILE_BACKUP="postgresql_B.conf"
    local CMD_REPLACEMENT_PORT="s /port = 5432/port = $PORT_NUMBER_PG/g"
    local NAME_DB="db_muralha"
    local URL_BASE="localhost"
    local PATH_ARQ_SQL=`find .. -name "SQL-base.sql"`
    local PASSWORD_POSTGRES='PostgreSQL2021Muralha'
    local PORT_DEFAULT_PG=5432

    set -e
    set -x

    # Instalção do postgresql e a alteração da porta padrão

    if  [ $(install_postgresql) -eq 1 ]
    then
        if [ $(alteracao_porta_padrao_postgresql) -eq 1 ]
        then
            if [ $(db_muralha) -eq 1 ]
            then
                unset_variable
            else
                echo "Falha ao criar a base de dados e suas tabelas!"
                unset_variable
            fi           
        else
            echo "Falha na alteração da porta padrão do Postgres!"
            unset_variable
        fi
    else
        echo "Falha na Instalação do PostgreSQL & PostGIS!"
        unset_variable
    fi

}


function instalando_criando_bk_muralha() {

    set -e
    set -x

    if  [ $(instalacao_python_e_componentes) -eq 1 ]
    then
        if [ $(criando_vm_e_instalando_bibliotecas) -eq 1 ]
        then
            #VM para o muralha foi criado com sucesso
            echo "VM criada com sucesso!"          
        else
            echo "Falha ao criar a VM para o Muralha e instalação de suas bibliotecas!"
        fi
    else
        echo "Falha na Instalação do Python e seus Componentes!"
    fi

    set +x
        
}

instalando_criando_bk_muralha
instalando_configurando_criado_db_muralha
