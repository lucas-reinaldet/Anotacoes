
# volumes Anonimos
# /data é a localização do volume anonimo.

docker run -v "/data" --name nome_container -e [opcoes image] image:tag

# Volumes Nomeados
# Named
# O volume possui um nome e pode ser facilmente referenciado
# Possui a mesma funcionalidade do volume anonimo

docker run -v "nome_volume":"/data" --name nome_container -e [opcoes image] image:tag

# Bind Mount
# É um volume, entretanto é localizado no diretório que nós especificamos

docker run -v "/opt/projeto/data":"/data" --name nome_container -e [opcoes image] image:tag
