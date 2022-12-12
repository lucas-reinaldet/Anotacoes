
# Orquestrador de Containers
# Pertence a propria Docker
# Pode escalar Horizontalmente os projetos de forma simples;
# Comandos Semelhantes ao Docker
# Já vem instalado com o Docker


# conceitos

# Nodes: É uma Instância (Máquina) que participa do Swarm;
# Manager Node: Node que gerencia os demais Nodes;
# Worker Node: Nodes que Trabalham em Função do Manager;
# Service: Um conjunto de Tasks que o Manager Node Manda o Work Node Executar;
# Task: Comandos Que são executados nos Nod2es;

# Docker Labs
# https://labs.play-with-docker.com/

### Iniciar o Swarm

docker swarm init

# Em alguns casos é necessário indicar o IP do Servidor atraves da flag -advertise-addr
docker swarm init --advertise-addr 192.168.0.18

# Fazendo com que a instancia/maquina vire um Node
# E vira também um Manager por ser a primeira maquina iniciada

# Vai ser gerado um Token e um comando para adicionar outros nodes ao Swarm
# Connectando as máquinas
# Entra na Hierarquia como Worker
# Todas as Tasks utilizadas no Manager serão replicadas em Nodes que foram adicionadas com Join

docker swarm join --token SWMTKN-1-0jy84vfusia06yndn65hh9g1m4lvqzncr5lbc1do8o7o47uiua-1zgqteabr8793e6lf9duucff9 192.168.0.18:2377

# Quando executado, é apresentado a seguinte mensagem:
# This node joined a swarm as a worker

# Sair do swarm - Se vc é o Manager, é necessário o -f paraa forçar a saida
# Se fizer isso em um worker, o mesmo continuara mapeado
# entretanto o seu status será down.
docker swarm leave -f

### Verificar os nodes ativos:

# Permitindo saber o que está sendo orquestrado
# Observação: Só pode ser executado no Manager
docker node ls

# Observações:
# ID = Id de identificação
# HOSTNAME = IP do node
# STATUS = Status do Node
# AVAILABILITY = Está recebendo Comandos
# Manager Status = Indica quem é o Manager
# Engine Version = Versão da Engine

### Subir um Serviço

# docker service create --name <name> <image>

# Adiciona um container novo em nosso Manager
# E será gerenciado pelo Swarm;

docker service create --name nginxswarm -p 80:80 nginx


## Flag Replicas

# Uma Taks será emitida, replicando esse serviço nos Workers

docker service create --name nginxreplicas -p 80:80 --replicas 3 nginx

# Essa imagem será rodada em 3 Workers, para verificar é necessário usar o docker ps nesses nodes

# em Docker Labs, deve-se clicar em Open Port e disponibilizar a porta 80 para o teste
# será aberto uma nova aba com o resultado

### Listar os Serviços

# Apresentará todos os serviços iniciados
# E informações consideradas relevantes - igual ao docker ps
# Observação: Só pode ser executado no Manager

docker service ls

# ID = Id do Serviço
# NAME = Nome do Serviço
# MODE = Modo de executação do Serviço
# REPLICAS = Numero de Replicas - 1/1 Singigica que esta rodando em apenas um Node
# IMAGE = Imagem
# PORTS = Portas Utilizadas

# Remover um Serviço

# docker service rm <nome ou id>

docker service rm nginxswarm

### Remover um container de um Worker

# isso fará com que o Swarm reinicie este container novamente;
# pois o serviço ainda está rodando no Manager, e isto é uma de suas atribuições: Garantir que os serviços estejam sempre disponiveis.
# Necessário usar o -f

docker container rm id -f

# Ao executar isso em um Workers, automaticamente o container será reiniciado em dentro
# de alguns segundos pelo Manager nesse Worker


### Recuperar o Token

# Só pode ser executado no Manager

docker swarm join-token manager

### Checando informações do Swarm

docker info

# Terá toda a informação do docker
# A chave swarm: indica se esta ativo ou não
# e terá informações como identificação, se é manager, quantidade de managers, 
# quantidade de nodes, e informações de rede

## Removendo um Node do Manager

docker node rm <node>

# ao usar o Join no node removido
# dará um erro informando que não teve uam resposta do Manager e parou o Serviço
# sendo listado como down no Manager, sendo um bug já conhecido pela comunidade
# sendo necessário refazer um "restart" em toda a estrutura
# Dando o leave em todos os nodes e conectando novamente aos serviços



### Inspecionar serviço

docker service inspect <servico>

# Retornará informações como nome, data de criação, portas entre outros.

### Compose Swarm

docker stack deploy -c <arquivo.yaml> <nome>

# exemplo:


echo """version: '3.3'

services:
  web:
    image: nginx
    ports: 
      - 80:80""" >> docker-compose.yaml

docker stack deploy -c docker-compose.yaml nginx_swarm

### Escalar serviço
# aumenta o grau de replicação dos serviços

docker service scale nginx_swarm_web=3

### Atualizar Parametros do Serviço

## Limitar Serviço de receber mais Task do Manager
# Desativar
docker node update --availability drain <id>

# Ativar
docker node update --availability active <id>

# Atualizar o network do Serviço
docker service update --network <network> <id>

## Criar Rede para o Swarm

# Serve para o isolamento dos serviços
# Criar uma rede Docker
docker network create --driver overlay swarm

# listar networks
docker network ls

# Criar um serviço com o network setado
docker service create --name nginxreplicas --replicas 3 -p 80:80 --network swarm nginx

