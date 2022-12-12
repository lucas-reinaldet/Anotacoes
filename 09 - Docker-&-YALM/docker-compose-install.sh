## Certifique-se de que não existe nenhuma versão antiga instalada removendo-a
sudo apt-get remove docker docker-engine docker.io containerd runc

## Atualize o repositório
sudo apt-get update

## Instale pacotes necessários
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y

## Adicione a chave oficial do Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

## Verifique se a chave foi adicionada
sudo apt-key fingerprint 0EBFCD88

## Adicione o repositório do Docker
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

## Instale o Docker
sudo apt-get install docker -y

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

## Criando um Grupo Docker
groupadd docker

## Adicionar o Usuário no grupo Docker
sudo usermod -a -G docker $(whoami)

## Este comando é 'uma gambiarra' que adiciona o nosso usuário a um grupo 'virtual' 
## que demos o nome de docker para evitar que tenhamos que reiniciar o computador.
newgrp docker

## Verificar se foi instalado corretamente.
docker version

docker compose version
