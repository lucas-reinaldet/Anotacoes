sudo apt update

sudo apt install openjdk-8-jdk -y

readlink -f $(which javac)

LOCAL_JAVA="$(readlink -f $(which javac))"

echo "
export JAVA_HOME=${LOCAL_JAVA%%'/bin/javac'}" >> ~/.bashrc

source ~/.bashrc

sudo apt-get install python2.7 -y

wget https://dlcdn.apache.org/cassandra/3.11.12/apache-cassandra-3.11.12-bin.tar.gz

tar -xzf apache-cassandra-3.11.12-bin.tar.gz

sudo mkdir /opt/cassandra && sudo mv apache-cassandra-3.11.12/ /opt/cassandra/

sudo rm -r apache-cassandra-3.11.12-bin.tar.gz

sudo ln -s /opt/cassandra/apache-cassandra-3.11.12 /opt/cassandra/default
# sudo ln -s /opt/cassandra/apache-cassandra-3.11.11 /opt/cassandra/default

echo '
export CASSANDRA_HOME=/opt/cassandra/default
export CASSANDRA_BIN=$CASSANDRA_HOME/bin
export CASSANDRA=$CASSANDRA_BIN/cassandra
export CASSANDRA_CQLSH=$CASSANDRA_BIN/cqlsh
export PATH=$PATH:$CASSANDRA_BIN
' >> ~/.bashrc

source ~/.bashrc

sudo nano $CASSANDRA_HOME/conf/cassandra.yaml

# nano /opt/cassandra/default/conf/cassandra.yaml

# cluster_name: -> Nome do cluster

# listen_address: -> IP da máquina onde esta rodando o cassandra

# rpc_address: -> IP da Propria máquina

# seeds: -> Todos os IP's que tem o cassandra instalado (Tanto o ip local, quanto o ip das outras máquinas)

sh $CASSANDRA -f

sh $CASSANDRA_BIN
