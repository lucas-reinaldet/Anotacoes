#!/usr/bin/bash

FOLDER=`find ~ -type d -name "Projeto_muralha"`

function instalacao_python_e_componentes() {

    local FILE="/Script_Instalacao/log_backend_muralha.log"
    
    {  
        echo "Inicio: `date +%d-%m-%y_%H:%M:%S`"

        set -x
        set -e

        echo
        echo "Instalação do Python 3.8"
        sudo apt-get install python3.8 -y

        echo
        echo "Instalação do Venv!"
        sudo apt-get install python3.8-venv -y

        echo 
        echo "Instalação do pip8!"
        sudo apt-get install pip -y

        set +e
        set +x

        echo
        echo "Fim: `date +%d-%m-%y_%H:%M:%S`"
    } >> "${FOLDER}${FILE}"

    echo 1
}

function criando_vm_e_instalando_bibliotecas() {

    local FILE="/Script_Instalacao/log_backend_muralha.log"
    
    {   
        echo "Inicio: `date +%d-%m-%y_%H:%M:%S`"

        set -x
        set -e

        echo
        echo "Criando uma VM para o Muralha (Python3)"
        python3 -m venv "${FOLDER}/vm_muralha"

        echo
        echo "Iniciando a VM para a Instalação das Bibliotecas do Python"
        source "${FOLDER}/vm_muralha/bin/activate"

        echo
        echo "Instalação das Bibliotecas do Python | Instalação do Psycopg2-binary"
        pip install psycopg2-binary

        echo
        echo "Instalação das Bibliotecas do Python | Instalação do Pandas"
        pip install pandas

        echo
        echo "Instalação das Bibliotecas do Python | Instalação do Requests"
        pip install requests

        echo
        echo "Instalação das Bibliotecas do Python | Instalação do Django"
        pip install django

        echo
        echo "Instalação das Bibliotecas do Python | Instalação do Django-Rest-Framework"
        pip install djangorestframework

        echo
        echo "Instalação das Bibliotecas do Python | Django-Rest-Framework | Instalação do Markdown"
        pip install markdown 

        echo
        echo "Instalação das Bibliotecas do Python | Django-Rest-Framework | Instalação do django-filter"
        pip install django-filter

        echo 
        echo "Desligandoo VM"
        deactivate

        set +e
        set +x

        echo "Fim: `date +%d-%m-%y_%H:%M:%S`"
    } >> "${FOLDER}${FILE}"

    echo 1

}

function install_postgresql() {

    local FILE="/Script_Instalacao/log_backend_db_muralha.log"
    
    {   
        echo "Inicio: `date +%d-%m-%y_%H:%M:%S`"
        
        set -x  

        echo 
        echo "Atualização do repositório do Postgresql"
        sudo sh -c '# deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
        wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

        echo "Atualizando o repositório do PostGis"
        wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -

        echo "Update do Sistema!"
        sudo apt-get update -y

        echo "Instalação Pacotes essenciais para o Postgresql"
        echo "Pacotes que serão instalados:"
        echo "build-essential"
        sudo apt-get install build-essential -y

        echo 
        echo "Instalação do libreadline-dev"
        sudo apt-get install libreadline-dev -y
        
        echo 
        echo "Instalação do zlib1g-dev"
        sudo apt-get install zlib1g-dev -y
        
        echo 
        echo "Instalação do gettext"
        sudo apt-get install gettext -y
        
        set -e

        echo 
        echo "Instalação do Postgresql versão 13 & Postgres Common"
        sudo apt-get -y install postgresql-13 -y
        sudo apt-get install -y postgresql-common -y
        
        echo 
        echo "Instalação do PostGis para o Postgresql de versão 13 | Parte 01"
        sudo apt-get install postgresql-13-postgis-3 -y
        
        echo 
        echo "Instalação do PostGis para o Postgresql de versão 13 | Parte 02"
        sudo apt-get install postgresql-13-postgis-3-scripts -y
        
        echo 
        echo "Instalação do PostGis para o Postgresql de versão 13 | Parte 03"
        sudo apt-get install postgis -y

        set +e
        set +x

        echo "Fim: `date +%d-%m-%y_%H:%M:%S`"

    } >> "${FOLDER}${FILE}"

    echo 1

}

function alteracao_porta_padrao_postgresql() {

    local FILE="/Script_Instalacao/log_backend_db_muralha.log"
    local RESULTADO=0
    local NAME_FILE='postgresql.conf'
    local PORT_DEFAULT_PG=5432
    local PORT_NUMBER_PG=7979
    local FOLDER_PS_HBA=`find /etc/ /var/lib/ -type f -name "pg_hba.conf" 2>/dev/null`
    local FOLDER_PS_CONF=`find /etc/ /var/lib/ -type f -name "postgresql.conf" 2>/dev/null`

    {   
        echo "Inicio: `date +%d-%m-%y_%H:%M:%S`"

        set -x
        set -e
        echo 
        echo "Iniciando a configuração do PostgreSQL"
        # Dando permissão de alteração do arquivo ${NAME_FILE}"
        # sudo chmod -c 666 "${FOLDER_PS_CONF}"

        echo 
        echo "PostgreSQL | Criando uma cópia de segurança do arquivo ${NAME_FILE} na pasta local"
        sudo cat ${NAME_FILE}| sed "s/port = $PORT_DEFAULT_PG/port = $PORT_NUMBER_PG/g" "${FOLDER_PS_CONF}" >> ${NAME_FILE}

        echo
        echo "PostgreSQL | Trocando a porta padrão 5432 para 7979"

        if [ -f "${NAME_FILE}" ] 
        then
            TAM_FILE_ALTER=`stat -c%s "${NAME_FILE}"`
            TAM_FILE_ORINAL=`stat -c%s "${FOLDER_PS_CONF}"`
            SHA256_FILE_ALTER=`sha256sum "${NAME_FILE}" | cut -d' ' -f1`
            SHA256_FILE_ORIGINAL=`sha256sum "${FOLDER_PS_CONF}" | cut -d' ' -f1`
            
            if [ ${TAM_FILE_ALTER# 0} -eq ${TAM_FILE_ORINAL# 0} ] && [ "${SHA256_FILE_ALTER}" != "${SHA256_FILE_ORIGINAL}" ]
            then   
                
                echo
                echo "Arquivo copiado e alterado com sucesso!"             
                
                sudo rm -r "${FOLDER_PS_CONF}" 
                
                sudo mv "${NAME_FILE}" "${FOLDER_PS_CONF//${NAME_FILE}/''}"
                
                sudo chown root:root "${FOLDER_PS_HBA}"

                sudo chown postgres:postgres "${FOLDER_PS_CONF}"

                sudo chmod 744 "${FOLDER_PS_HBA}"
                
                echo "Arquivo modificado com sucesso"

                echo
                echo "PostgreSQL | Reiniciando o Server do PostgreSQL"
                sudo systemctl restart postgresql@13-main
                
                echo "Atualização da porta foi realizado com sucesso"
                local RESULTADO=1            
            fi
        fi
        
        # PostgreSQL | Retirando as Permissões de alteração do ${NAME_FILE}"
        # sudo chmod 644 "${FOLDER_PS_CONF}"

        set +x
        set +e

        echo
        echo "Fim: `date +%d-%m-%y_%H:%M:%S`"

    } >> "${FOLDER}${FILE}"

    echo ${RESULTADO}
}

function db_muralha() {

    local FILE="/Script_Instalacao/log_backend_db_muralha.log"
    local RESULTADO=0

    {   
        echo "Inicio: `date +%d-%m-%y_%H:%M:%S`"

        set -x
        set -e

        echo        
        echo "PostgreSQL | Localizando o arquivo SQL-base.sql para a criação da base de dados ${NAME_DB} do Muralha"
        
        # PATH_ARQ_SQL=`find .. -name "SQL-base.sql"`

        # PostgreSQL | Realizando a troca de senha do usuário Postgres: "
        # passwd postgres
        
        echo
        echo "PostgreSQL | Criando a senha da base para o usuário postgres"
        sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '$PASSWORD_POSTGRES'"

        echo
        echo "PostgreSQL | Criando o usuário ${NAME_USER_DB} para o Banck-end se Conectar ao Banco."
        sudo -u postgres psql -c "CREATE USER ${NAME_USER_DB} WITH NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT ENCRYPTED PASSWORD '${PWD_USER_POSTGRES}'"

        echo
        echo "PostgreSQL | Mudando o Time Zone do Banco para GMT-3 (Brasilia)"
        sudo -u postgres psql -c "SET TIME ZONE 'GMT-3'"

        # echo
        # echo "PostgreSQL | Criando a base ${NAME_DB} e atribuindo como dono ${NAME_USER_DB}"
        # sudo -u postgres psql -c "CREATE DATABASE ${NAME_DB} OWNER ${NAME_USER_DB}"

        # echo
        # echo "PostgreSQL | Criando o Schema ${NAME_SCHEMA_M}"
        # sudo -u postgres psql -c "CREATE SCHEMA ${NAME_SCHEMA_M}"

        # echo
        # echo "PostgreSQL | Criando a Extension do ${NAME_EXTENSION}"
        # sudo -u postgres psql -c "CREATE EXTENSION ${NAME_EXTENSION}"

        echo
        echo "PostgreSQL | ${NAME_DB} | Criando e configurando a base de dados"
        sudo -u postgres pg_restore -c -C -d postgres "${PATH_ARQ_SQL}"

        echo
        echo "PostgreSQL | Atribuindo permissões ao usuário ${NAME_USER_DB}"
        echo "PostgreSQL | Privilégios à base de dados ${NAME_DB}"
        sudo -u postgres psql -c "GRANT ${PRIVILEGES_DB} ON DATABASE ${NAME_DB} TO ${NAME_USER_DB}"
        
        echo
        echo "PostgreSQL | Utilização dos Schemas"
        sudo -u postgres psql -d db_muralha -c "GRANT ${PRIVILEGES_SCHEMAS} ON SCHEMA ${SCHEMAS_DB} TO ${NAME_USER_DB}"

        echo
        echo "PostgreSQL | Utilização das Tableas"
        sudo -u postgres psql -d db_muralha -c "GRANT ${PRIVILEGES_TABLES} ON ${TABLES} IN SCHEMA ${SCHEMAS_DB} TO ${NAME_USER_DB}"
        
        set +e
        set +x

        local RESULTADO=1

        echo
        echo "Fim: `date +%d-%m-%y_%H:%M:%S`"
    } >> "${FOLDER}${FILE}"

    echo ${RESULTADO}
}

# function unset_variable_db() {

#     set +x

#     unset NAME_USER_DB
#     unset PWD_USER_POSTGRES
#     unset PORT_NUMBER_PG
#     unset FOLDER_PS_CONF
#     unset NAME_FILE
#     unset NAME_FILE_BACKUP
#     unset NAME_DB
#     unset URL_BASE
#     unset PATH_ARQ_SQL
#     unset PASSWORD_POSTGRES
#     unset PORT_DEFAULT_PG
#     unset NAME_EXTENSION
#     unset NAME_SCHEMA

#     set -x
# }

# function unset_variable_bk() {

#     set +x

#     unset FILE
#     unset EMAIL_USER_DJANGO
#     unset SUPER_USER_DJANGO
#     unset PASSWORD_USER_DJANGO

#     set -x
# }

function criar_arquivo_gitignore() {
    
    local FILE="/Script_Instalacao/log_backend_muralha.log"
    
    {   
        echo "Inicio: `date +%d-%m-%y_%H:%M:%S`"
        
        local ARQ_GIT_IGNORE="${FOLDER}/.gitignore"
        local CONTENT_ARQ="
# ignorar a vm criada
vm_muralha/

# ignorar todos os logs
*.log

# ignorar cache python
*/__pycache__/
*.pyc

# ignorar README-Django, já que o mesmo é gerado de acordo de onde é executado
README-Django
"
        sudo echo "${CONTENT_ARQ}" > ${ARQ_GIT_IGNORE}

        echo
        echo "Foi criado em: ${FOLDER}"
        echo "um arquivo .gitignore para ignorar: "
        echo
        echo "${CONTENT_ARQ}"
        echo
        echo "Fim: `date +%d-%m-%y_%H:%M:%S`"

    } >> "${FOLDER}${FILE}"
}

function configurando_django() {

    set +x

    local FILE="/Script_Instalacao/log_backend_muralha.log"
    local FILE_INF="/README-Django"
    local EMAIL_USER_DJANGO="muralha@pti.org.br"
    local SUPER_USER_DJANGO="muralha"
    local PASSWORD_USER_DJANGO="Muralha2021"

    {   
        echo "Inicio: `date +%d-%m-%y_%H:%M:%S`"
        
        set -x

        echo
        echo "Iniciando a VM para configuração do Django"
        source  "${FOLDER}/vm_muralha/bin/activate"

        python3 "${FOLDER}/bk_muralha/manage.py" makemigrations

        python3  "${FOLDER}/bk_muralha/manage.py" migrate

        echo
        echo "Criando o usuário"
        echo "from django.contrib.auth.models import User; User.objects.filter(email='${EMAIL_USER_DJANGO}').delete(); User.objects.create_superuser('${SUPER_USER_DJANGO}', '${EMAIL_USER_DJANGO}', '${PASSWORD_USER_DJANGO}')" | python "${FOLDER}/bk_muralha/manage.py" shell

        # echo
        # echo "Iniciando o server do Django para acesso via Browser!"
        # python3 ../bk_muralha/manage.py runserver

        # echo
        # echo "Server Iniciado: Acesso via = http://127.0.0.1:8000/"

        echo
        echo "Desligan a VM"
        deactivate

        {
            echo "`date +%d-%m-%y_%H:%M:%S`

Olá, seja bem vindo!

Se chegamos até aqui, significa que todas as instalações e configurações do Django
Foram realizadas com Sucesso!!!

Agora vamos para a etapa final, o momento que estavamos esperando! Executar o nosso projeto!!!

Antes de qualquer coisa;

Foi realizado a alteração da senha do usuário postgres:

Senha: ${PASSWORD_POSTGRES}

Foi criado um usuário de acesso ao banco de dados para o Django:

Usuário: ${NAME_USER_DB}
Senha: ${PWD_USER_POSTGRES}

E foi criado um super usuário para acesso ao Django

Usuário: ${SUPER_USER_DJANGO}
E-mail Genérico: ${EMAIL_USER_DJANGO} #não se preocupe, não utilizaremos esse e-mail!
Senha: ${PASSWORD_USER_DJANGO}

Para iniciarmos o projeto, será necessário executar a VM criada para o projeto:

Execute em seu terminal:

source  '${FOLDER}/vm_muralha/bin/activate'

Agora com a VM iniciada, execute:

python3 '${FOLDER}/bk_muralha/manage.py' runserver

No terminal onde o comando anterior foi executado, deverá mostrar uma URL de acesso.

Um exemplo desta URL: http://127.0.0.1:8000/

Observação: A URL pode variar de acordo com a máquina!

Ao acessar a URL, será apresetado a página inicial do Projeto Muralha. A partir daqui,
fique à vontade para conhecer o sistema e caso precise de algo, a Equipe do Muralha se encontra a 
disposição!

Atenciosamente;

Equipe Muralha;
Projeto Muralha Inteligente;
Centro de Competências Tecnologias Abertas e IoT;
Fundação Parque Tecnológico Itaipu – Brasil;
            "
        } >> "${FOLDER}${FILE_INF}"

        set +x
        echo
        echo "Fim: `date +%d-%m-%y_%H:%M:%S`"
        

    } >> "${FOLDER}${FILE}"

}


function instalando_configurando_criado_db_muralha() {

    set +x
    
    local NAME_USER_DB='us_db_muralha'
    local PWD_USER_POSTGRES='DBMuralha2021'
    local NAME_DB='db_muralha'
    local URL_BASE='localhost'
    local PATH_ARQ_SQL=`find ~ -type f -name "SQL-base"`
    local PASSWORD_POSTGRES='PostgreSQL2021Muralha'
    local NAME_EXTENSION='postgis'
    local PRIVILEGES_TABLES='DELETE, REFERENCES, SELECT, INSERT, UPDATE'
    local TABLES='ALL TABLES'
    local SCHEMAS_DB='sc_muralha,public'
    local PRIVILEGES_SCHEMAS='USAGE'
    local PRIVILEGES_DB='CONNECT, CREATE'

    set -x

    #  Instalção do postgresql e a alteração da porta padrão

    local FILE="/Script_Instalacao/log_backend_db_muralha.log"
    local RESULT=0

    {   
        echo "Inicio: `date +%d-%m-%y_%H:%M:%S`"

        if  [ $(install_postgresql) -eq 1 ]
        then
            echo                
            echo "Instalação do PostgreSQL foi realizada com sucesso!"

            if [ $(alteracao_porta_padrao_postgresql) -eq 1 ]
            then
                echo                
                echo "Configuração do PostgreSQL foi realizada com sucesso!"

                if [ $(db_muralha) -eq 1 ]
                then
                    echo                
                    echo "Base de dados foi criada com sucesso!"
                    
                    echo
                    echo "Atualizando o sistema"

                    sudo apt-get update

                    echo                
                    echo "Instalação e configuração do PostgreSQL e, Criação da base de dados do Muralha foram realizada com sucesso!"
                    # unset_variable

                    local RESULT=1

                else
                    echo "Falha ao criar a base de dados e suas tabelas!"
                    # unset_variable
                fi           
            else
                echo "Falha na alteração da porta padrão do Postgres!"
                # unset_variable
            fi
        else
            echo "Falha na Instalação do PostgreSQL & PostGIS!"
            # unset_variable
        fi

        set +x
        echo
        echo "Fim: `date +%d-%m-%y_%H:%M:%S`"

    } >> "${FOLDER}${FILE}"

    echo ${RESULT}
}

function instalando_criando_bk_muralha() {

    local FILE="/Script_Instalacao/log_backend_muralha.log"
    local RESULT=0
    { 
        echo "Inicio: `date +%d-%m-%y_%H:%M:%S`"

        set -x
        set -e

        if  [ $(instalacao_python_e_componentes) -eq 1 ]
        then

            echo
            echo "Instalação do Python de seus componentes foram realizados com sucesso!"  

            if [ $(criando_vm_e_instalando_bibliotecas) -eq 1 ]
            then

                echo
                echo "Instalação das Bibliotecas necessárias para o funcionamento do Django foram realizadas com sucesso!"

                echo
                echo "Criando arquivo GITIGNORE"                
                criar_arquivo_gitignore

                echo
                echo "Configurando Django"                
                configurando_django

                echo
                echo "Atualizando o sistema"

                sudo apt-get update

                # unset_variable_bk

                local RESULT=1

                echo
                echo "Python, Componentes e instalação das bibliotecas foram realizadas com sucesso!"          
            else
                echo "Falha ao criar a VM para o Muralha e instalação de suas bibliotecas!"
            fi
        else
            echo "Falha na Instalação do Python e seus Componentes!"
        fi

        set +x
        set +e

        echo
        echo "Fim: `date +%d-%m-%y_%H:%M:%S`"

    } >> "${FOLDER}${FILE}"

    echo ${RESULT}     
}

function func_main() {

    if  [ $(instalando_configurando_criado_db_muralha) -eq 1 ]
    then

        echo
        echo "A base de dados do Muralha foi criada com Sucesso!"

        if  [ $(instalando_criando_bk_muralha) -eq 1 ]
        then
            echo
            echo "O Backend do Muralha foi criado com Sucesso!"

            echo
            echo "Limpando variaveis criadas para a instalação!"
            sudo apt-get autoremove -y
            sudo apt-get clean -y

        else
            echo
            echo "Falha ao criar o Backend do Muralha!"
        fi
    else
        echo
        echo "Falha ao criar a base de dados do Muralha!"
    fi

}

func_main