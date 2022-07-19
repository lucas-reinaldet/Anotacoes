#atualizar pacotes de sistema
sudo apt update
sudo apt -y upgrade

#instalar Java
sudo apt install curl mlocate default-jdk -y

#verificar versão
java -version

# Download
# Verificar a versão no proprio site da Apache.
# Arquivo Binario
wget https://dlcdn.apache.org/kafka/3.2.0/kafka_2.13-3.2.0.tgz

# descompactar
tar -xzf kafka_2.13-3.2.0.tgz

# Remover arquivo TGZ
rm kafka_2.13-3.2.0.tgz

# Mover a pasta para o diretorio do usuário.
mv kafka_2.13-3.2.0 ~/ 

# Criar um link Simbolico
ln -s kafka_2.13-3.2.0/ kafka