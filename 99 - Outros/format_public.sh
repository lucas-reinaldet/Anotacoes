function variaveis() {

    # Variaveis utilizadas para configurar o Postgres
    export DB_PWD_USER_POSTGRES='30894'
    export DB_NEW_PORT_PG=8500
    export DB_PORT_DEFAULT_PG=5432
    export DB_USER_POSTGRES='postgres'
    export DB_NAME_FILE_CONF_POSTGRESQL='postgresql.conf'
    export DB_NAME_FILE_HBA_POSTGRESQL='pg_hba.conf'
    export DB_FOLDER_PG_HBA=`find /etc/ /var/lib/ -ipath *13* -type f -name "${DB_NAME_FILE_HBA_POSTGRESQL}" 2>/dev/null`
    export DB_FILE_CONF_PG=`find /etc/ /var/lib/ -ipath *13* -type f -name "${DB_NAME_FILE_CONF_POSTGRESQL}" 2>/dev/null`
}

function configuracoes_essenciais() {
    
    echo "Atualização e Upgrade do Sistema."
    sudo apt update -y && sudo apt upgrade -y

    echo "Instalação do Net-tools."
    sudo apt install net-tools -y

    echo "Instalação do Python3."
    sudo apt-get install python3 -y

    echo "Instalação do Venv."
    sudo apt-get install python3-venv -y

    echo "Instalação do PIP."
    sudo apt install python3-pip

    echo "Instalação do GIT."
    sudo apt-get install git -y
    
    echo "Instalação do JQ.."
    sudo apt-get install jq -y

    echo 'Instalação wget'
    sudo apt-get install wget

    echo 'Instalação de Curl'
    sudo apt-get install curl -y

    echo 'Instalação SSH'
    sudo apt-get install openssh-server -y

    echo 'Instalação Spotify'
    snap install spotify

    echo 'instalar Java'
    sudo apt install curl mlocate default-jdk -y

    echo 'Instalar Controle de Voz'
    sudo apt-get install pavucontrol

    echo 'Sincronizar com o projeto de Anotações do GIT'
    mkdir ~/'Área de Trabalho'/Projetos
    git clone https://github.com/lucas-reinaldet/Anotacoes.git ~/'Área de Trabalho'/Projetos/'00 - Anotacoes'

    echo "Selecionando Driver da NVIDIA."
    local DRIVER_NVIDIA=""
    for i in $(ubuntu-drivers devices)
    do
        if [[ ${i} == *"nvidia-driver-"* ]]
        then
            DRIVER_NVIDIA="$i"
        elif [[ ${i} == *"recommended"* ]]
        then
            break
        fi
    done

    echo "Instalação do Driver ${DRIVER_NVIDIA}."
    sudo apt-get install ${DRIVER_NVIDIA} -y

    echo "Instalação do VLC."
    sudo snap install vlc

    sudo snap install antares


}

function install_postgresql_pgadmin() {
    
    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    sudo curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add
    sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'

    echo "Atualizando o repositório do PostGis"
    wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -

    echo "Update do Sistema!"
    sudo apt-get update -y

    echo "Instalação Pacotes essenciais para o Postgresql"
    echo "build-essential"
    sudo apt-get install build-essential -y

    echo "Instalação do libreadline-dev"
    sudo apt-get install libreadline-dev -y
    
    echo "Instalação do zlib1g-dev"
    sudo apt-get install zlib1g-dev -y
    
    echo "Instalação do gettext"
    sudo apt-get install gettext -y

    echo "Instalação do Postgresql versão 13 & Postgres Common"
    sudo apt-get -y install postgresql-13 -y
    sudo apt-get install -y postgresql-common -y
    
    echo "Instalação do PostGis para o Postgresql de versão 13 | Parte 01"
    sudo apt-get install postgresql-13-postgis-3 -y
    
    echo "Instalação do PostGis para o Postgresql de versão 13 | Parte 02"
    sudo apt-get install postgresql-13-postgis-3-scripts -y
    
    echo "Instalação do PostGis para o Postgresql de versão 13 | Parte 03"
    sudo apt-get install postgis -y

    # echo "Instalação do PGAdmin4."
    sudo apt install pgadmin4-desktop -y

    echo "PostgreSQL | Criando a senha da base para o usuário postgres"
    sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '${DB_PWD_USER_POSTGRES}'"

    echo "PostgreSQL | Mudando o Time Zone do Banco para GMT-3 (Brasilia)"
    sudo -u postgres psql -c "SET TIME ZONE 'GMT-3'"

    alteracao_porta_padrao_postgresql

}

function alteracao_porta_padrao_postgresql() {

    echo "Iniciando a configuração do PostgreSQL"

    echo "PostgreSQL | Criando uma cópia de segurança do arquivo ${DB_NAME_FILE_CONF_POSTGRESQL} na pasta local"
    if [ -f "${DB_NAME_FILE_CONF_POSTGRESQL}" ]
    then
        sudo rm -r ${DB_NAME_FILE_CONF_POSTGRESQL}
    fi

    sudo cat ${DB_NAME_FILE_CONF_POSTGRESQL}| sed "s/port = ${DB_PORT_DEFAULT_PG}/port = ${DB_NEW_PORT_PG}/g" "${DB_FILE_CONF_PG}" >  ${DB_NAME_FILE_CONF_POSTGRESQL}

    echo "PostgreSQL | Trocando a porta padrão ${DB_PORT_DEFAULT_PG} para ${DB_NEW_PORT_PG}"

    if [ -f "${DB_NAME_FILE_CONF_POSTGRESQL}" ] 
    then
        set +x

        local TAM_FILE_ALTER=`stat -c%s "${DB_NAME_FILE_CONF_POSTGRESQL}"`
        local TAM_FILE_ORINAL=`stat -c%s "${DB_FILE_CONF_PG}"`
        local SHA256_FILE_ALTER=`sha256sum "${DB_NAME_FILE_CONF_POSTGRESQL}" | cut -d' ' -f1`
        local SHA256_FILE_ORIGINAL=`sha256sum "${DB_FILE_CONF_PG}" | cut -d' ' -f1`
        
        set -x
        
        if [ ${TAM_FILE_ALTER# 0} -eq ${TAM_FILE_ORINAL# 0} ] && [ "${SHA256_FILE_ALTER}" != "${SHA256_FILE_ORIGINAL}" ]
        then   
            
            echo "Arquivo copiado e alterado com sucesso!"             
            
            sudo rm -r "${DB_FILE_CONF_PG}" 
            
            sudo mv "${DB_NAME_FILE_CONF_POSTGRESQL}" "${DB_FILE_CONF_PG//${DB_NAME_FILE_CONF_POSTGRESQL}/''}"
            
            sudo chown root:root "${DB_FOLDER_PG_HBA}"

            sudo chown postgres:postgres "${DB_FILE_CONF_PG}"

            sudo chmod 744 "${DB_FOLDER_PG_HBA}"
            
            echo "Arquivo modificado com sucesso"

            echo "PostgreSQL | Reiniciando o Server do PostgreSQL"
            sudo systemctl restart postgresql@13-main
            
            echo "Atualização da porta foi realizado com sucesso"
            local RESULT=1 
        elif [ ${TAM_FILE_ALTER# 0} -eq ${TAM_FILE_ORINAL# 0} ] && [ "${SHA256_FILE_ALTER}" == "${SHA256_FILE_ORIGINAL}" ]
        then
            echo "Porta padrão do PostgreSQL já se encontra modificada!"

            echo "PostgreSQL | Reiniciando o Server do PostgreSQL"
            sudo systemctl restart postgresql@13-main

        fi
    fi
}

function unset_variaveis() {

    # Variavel Geral
    unset FOLDER
    unset ENV_FILE_SCHEMAS
    unset ENV_FILE_GERAL

    # Variaveis utilizadas para configurar a base de dados 
    unset DB_PWD_USER_POSTGRES
    unset DB_USER_POSTGRES
    unset DB_NEW_PORT_PG
    unset DB_PORT_DEFAULT_PG
    unset DB_FOLDER_PG_HBA
    unset DB_FILE_CONF_PG
    unset DB_NAME_FILE_CONF_POSTGRESQL
    unset DB_NAME_FILE_HBA_POSTGRESQL

    echo "O sistema será reiniciado!"
    reboot
}


function manual() {
    echo 'Instalação do Discord'
    sudo apt-get install -f
    wget -q -O discord.deb https://discord.com/api/download?platform=linux&format=deb 
    sudo dpkg -i discord.deb
    sudo rm -r discord.deb

    echo 'Instalação Google Chrome'
    wget -q https://www.google.com/chrome/thank-you.html?brand=BNSD&statcb=0&installdataindex=empty&defaultbrowser=0# 
    sudo dpkg -i chrome.deb 
    sudo rm -r chrome.deb

    echo 'Instalação VSCode'
    wget -q -O vscode.deb https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
    sudo dpkg -i vscode.deb 
    sudo rm -r vscode.deb

    echo 'Definir senha para o usuário postgres do linux'
    sudo passwd postgres 

    echo 'Instalação do OBS'
    sudo apt-get install ffmpeg
    sudo add-apt-repository ppa:obsproject/obs-studio
    sudo apt update
    sudo apt-get update && sudo apt-get install obs-studio
}

variaveis
configuracoes_essenciais
# install_postgresql_pgadmin
unset_variaveis
# Executar comandos do metodo Manual

# Abra o terminal (pressionando Ctrl+Alt+T).

# Verifique o tamanho da partição de swap atual com o comando:

# css
# Copy code
# sudo swapon --show
# Este comando exibirá o nome do arquivo de swap e o tamanho atual da partição de swap.

# Desative a partição de swap atual com o comando:
# bash
# Copy code
# sudo swapoff -v /swapfile
# Este comando desativará a partição de swap atual.

# Crie um novo arquivo de swap com o tamanho desejado com o seguinte comando:
# bash
# Copy code
# sudo fallocate -l <tamanho> /swapfile
# Substitua <tamanho> pelo tamanho desejado, por exemplo, "1G" para 1 gigabyte.

# Altere as permissões do arquivo de swap com o seguinte comando:
# bash
# Copy code
# sudo chmod 600 /swapfile
# Formate o arquivo de swap com o seguinte comando:
# bash
# Copy code
# sudo mkswap /swapfile
# Ative o novo arquivo de swap com o seguinte comando:
# bash
# Copy code
# sudo swapon /swapfile
# Verifique se a nova partição de swap está sendo usada corretamente com o comando:
# css
# Copy code
# sudo swapon --show
# Para tornar a nova partição de swap permanente, adicione-a ao arquivo /etc/fstab com o seguinte comando:
# bash
# Copy code
# echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
# Isso adicionará a nova partição de swap ao arquivo /etc/fstab, o que garantirá que ela seja ativada automaticamente na inicialização do sistema.