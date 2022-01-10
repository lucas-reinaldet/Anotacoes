# link https://www.mongodb.com/try/download/community

# Fazer download do arquivo,
# extrair arquivo, 
# excluir arquivo tar, 
# criar pasta em opt
# move arquivo para pasta criada
wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu2004-5.0.5.tgz && tar -zxvf mongodb*.tgz && rm mongodb*.tgz && sudo mkdir /opt/mongodb && sudo mv mongodb* /opt/mongodb

# Criar uma link simbolico para o arquivo executavel do node
cd /opt/mongodb
sudo ln -s mongodb-linux-x86_64-ubuntu2004-5.0.5/bin mongodb

# Indicar caminho do MongoDB Bin na variavel PATH
echo '
export MONGO_DB_HOME=/opt/mongodb/mongodb
export PATH=$PATH:$MONGO_DB_HOME
' >> ~/.bashrc

# Atualizar arquivo
source ~/.bashrc

# Executar MongoDB
mongod