# Links: https://www.hostinger.com.br/tutoriais/comandos-basicos-de-git?ppc_campaign=google_performance_max&gclid=CjwKCAjwhOyJBhA4EiwAEcJdcY22hcpi5SHU3Mlq_3rtH7H9JMSpphFAwXYw4qZOMRYkdofjpzr76BoCEoUQAvD_BwE
# Link: https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes

# Instala o GIT

sudo apt-get install git -y

# ________________________________

# Tranforma seu projeto em um repositorio:

git init

# ________________________________

# Verifica o Status de modificações e versões dos seus arquivos não publicados

git status

# ________________________________

# Para ignorar arquivos ou pastas, é necessário criar um arquivo chamado ".gitignore"
# na pasta onde foi dados o comando "git init" (pasta "mestra" do projeto).
#
# E dentro deste arquivo, escrever o nome da pasta que não será exportada.

Exemplo:

# ignorar a pasta da vm criada
vm/

# ignorar todos os logs
*.log

# ignorar cache python
*/__pycache__/
*.pyc

# ________________________________

# Realizar o upload do seu código para o seu git

git add .

# Depois de executado este commando, deverá ser executado:

git commit -m "Comentário sobre o upload dos dados"

# E para finalizar, basta executar

git push url_projeto nome_branch

# Observação: A url do projeto pode ser definida através do comando:

git remote add url_projeto

# Observação: O branch é uma funcionalidade de "Divisão" do projeto.
# Com ele é possivel tem por exemplo uma versão estavel (que normalmente se chama "Master")
# E a versão de desenvolvimento que pode possuir qualquer nomenclatura.

# ________________________________

# Branchs

# Imprimir branchs existentes localmente

git branch
git branch --list

# Imprimir Branchs (Repositorio e Local)

git branch --remotes

# Criar um novo branch

git branch nome_branch

# Ativar um branch para a publicação

git checkout nome_branch

# ________________________________

# Clonar repositorio


git clone https://git.<...>

# Observação: Irá clonar o repositorio padrão (normalmente o "master")

# Clonar repositorio com um Branch especifico

git clone https://git.<...> --branch nome_branch nome_pasta

# Observação: É possivel já definir o nome da pasta onde o projeto estará;
# caso não especificado, ele será definido como nomenclatura o nome do branch ou do repositório

# ________________________________

# Definir dados globais

# E-mail

git config --global user.email sam@google.com

# usuário

git config --global user.name sam@google.com

# Password

git config --global user.password sam@google.com

# ________________________________

# Listar todos os links de repositorios definidos

git remote -v

git remote add origin https://git.pti.org.br/celtab/muralha-inteligente/datalake/mi-ms-celepar.git



# ________________________________

# Atualizar repositório Local

git pull url_projeto nome_branch


# ________________________________

# Recuperando commits

git reflog

# Escolher o commit (código na frente de cada commit)

git merge {hash_commit}

# ________________________________

# Quando ocorre conflit oentre branchs distintas

# faça o checkout no branch ao qual esta ocorrendo conflito 

git checkout master

# faça o git pull para "Sincronizar" os branchs, selecione o branch ao qual
# vc deseja mesclar

git pull url_projeto nome_branch --allow-unrelated-histories

# Dê o git Status para verificar a situação do projeto

git status

# Execute o git add . para aceitar todas as mudanças

git add .

# Execute o git commit para preparar o commit dos dados no branch

git commit -m "Mensagem"

# Execute o push para adicionar as mudanças ao branch desejado

git push url_projeto master

____________________________________________

Considerar um arquivo base, para ignorar qualquer tipo de modificação no arquivo.

git update-index --assume-unchanged --add projeto/arquivo

reverter comando anterior 
git update-index --no-assume-unchanged --add projeto/arquivo

____________________________________________

O erro fatal: refusing to merge unrelated histories geralmente acontece quando você 
tenta fazer o git pull de um repositório remoto, mas o seu repositório local possuí 
um histórico de commits, branches, etc, diferente do que está no repositório remoto.

Para permitir que o Git faça o merge de dois projetos com históricos diferentes, é 
só passar o parâmetro --allow-unrelated-histories quando for fazer o pull, assim:

git pull origin master --allow-unrelated-histories