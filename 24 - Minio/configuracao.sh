
# o Alias serve para criar um atalho - arquivo de configuração -
# com especificações onde diminui
# a necessidade de declaração de variaveis a todo comando
# como ip, user e password.

# Configura o “alias” apontando para seu server MinIO local
mc alias set local http://127.0.0.1:9000 minioadmin minioadmin

# remover um alias
mc alias remove local

# Exemplo
mc admin info local

# Criar um arquivo de Serviço 
sudo nano /etc/systemd/system/minio.service

# Criando o usuário e grupo  indicado para iniciar o serviço
sudo groupadd -r minio-user

# -g adicioonar o user a determinado grupo
# -M Para não criar o diretorio para o usuário no diretório home
# -r Gera um Id para o usuário


# Criando 
sudo mkdir -p /mnt/data/disk1
sudo mkdir -p /mnt/data/disk2 
sudo mkdir -p /mnt/data/disk3 
sudo mkdir -p /mnt/data/disk4


sudo chown minio-user:minio-user /mnt/data/disk1 /mnt/data/disk2 /mnt/data/disk3 /mnt/data/disk4


# Criar arquivo de configuração do Minio
sudo nano /etc/default/minio


# Habilitar o Serviço
systemctl enable minio.service

# Resultado
# Created symlink /etc/systemd/system/multi-user.target.wants/minio.service → /etc/systemd/system/minio.service.


# Iniciar o Serviço
sudo systemctl start minio.service

# Desligar o Minio
sudo service minio stop
sudo systemctl stop minio.service


# Listar Buclkets -> local é o alias criado
mc ls local 

# mostra as portas abertas
nmap localhost