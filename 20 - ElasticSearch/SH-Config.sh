
# Devido ao alto consumo de memoria RAM, já que o Elastic possui uma configuração
# dinamica e baseada na quantidade de memoria disponivel, para ajustar o consumo de
# memoria, é necessário acessar o arquivo jvm.options
# localizado dentro da pasta config do Elasticsearch.
# As variaveis:
# -Xms -> Indica valor minimo de consumo de memoria
# -Xmx -> Indica o valor máximo de consumo de memoria
# PAra realizar um teste raṕido quanto am udança destas variaveis,
# basta usar o comando
# ES_JAVA_OPTS="-Xms2g -Xmx2g" ./elasticsearch/bin/elasticsearch
# Porem esse tipo de execução não é recomendado em ambiente de produção.

# Para mudar de forma "permanente" os valores, basta acessar o arquivo

nano ~/elasticsearch/config/jvm.options

# Descomentar as linhas onde está estas variaveis:

## -Xms4g
## -Xmx4g

# e mudar o valor de 4g para o valor desejado.
# obs: 
# Maximo e minimo é indicado que sejam iguais.
# Como a variavel está comentada, os valores de 4 Gigas não é aplicado 
# na configuração padrão.

# pode se usar o seguinte comando tbm para definir os parametros.

sed -i 's/## -Xms4g/-Xms3g/g' ~/elasticsearch/config/jvm.options
sed -i 's/## -Xmx4g/-Xmx3g/g' ~/elasticsearch/config/jvm.options
