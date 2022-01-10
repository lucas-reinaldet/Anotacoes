# link https://nodejs.org/en/

# Fazer download do arquivo,
# extrair arquivo, 
# excluir arquivo tar, 
# criar pasta em opt
# move arquivo para pasta criada
wget https://nodejs.org/dist/v16.13.1/node-v16.13.1-linux-x64.tar.xz && tar -xf node*.xz && rm node*.xz && sudo mkdir /opt/node && sudo mv node* /opt/node

# Criar uma link simbolico para o arquivo executavel do node
cd /opt/node
sudo ln -s node-v16.13.1-linux-x64/bin node
sudo ln -s /opt/node/node/node /usr/bin/node

# Criar uma link simbolico para o arquivo do npm
sudo ln -s /opt/node/node/npm /usr/bin/npm

# Criar uma link simbolico para o arquivo do npx
sudo ln -s /opt/node/node/npx /usr/bin/npx

# Indicar caminho do Node Bin na variavel PATH
sudo echo '
export NODE_HOME=/opt/node/node
export PATH=$PATH:$NODE_HOME
' >> ~/.bashrc

# Atualizar arquivo
source ~/.bashrc

# Executar node
node