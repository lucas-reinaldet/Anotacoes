
# Download do arquivo Deb do MinIo

wget https://dl.min.io/server/minio/release/linux-amd64/archive/minio_20221020005509.0.0_amd64.deb -O minio.deb

# Instalação

sudo dpkg -i minio.deb


# Criando a pasta para armazenar os arquivos de configuração

mkdir ~/minio

# iniciar um server, abrindo a comunicação do serviço na porta 9090
# Console-address -> Interface Gráfica
minio server ~/minio --console-address :9090

# Porta 9000 -> API
# Porta 9090 -> Interface Gráfica

# Será gerado user e senha padroes de conexão
# Status:         1 Online, 0 Offline. 
# API: http://10.0.2.15:9000  http://172.17.0.1:9000  http://192.168.49.1:9000  http://127.0.0.1:9000     
# RootUser: minioadmin 
# RootPass: minioadmin 
# Console: http://10.0.2.15:9090 http://172.17.0.1:9090 http://192.168.49.1:9090 http://127.0.0.1:9090   
# RootUser: minioadmin 
# RootPass: minioadmin 


# Instalando Executando o Minio Client

# Baixará a ultima versão do client
wget https://dl.min.io/client/mc/release/linux-amd64/mc

# Dando permissao de execução ao arquivo

chmod +x mc

# Mova para o diretorio de executaveis do linux
sudo mv mc /usr/local/bin/mc

# Teste de execução
mc --help

