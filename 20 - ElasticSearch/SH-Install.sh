# Install elastisearch
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.3.2-linux-x86_64.tar.gz

# Descompactar
tar -xzf elasticsearch-8.3.2-linux-x86_64.tar.gz

# Mover para o home
mv elasticsearch-8.3.2 ~/

# Criar Link Simbolico
ln -s elasticsearch-8.3.2 elasticsearch