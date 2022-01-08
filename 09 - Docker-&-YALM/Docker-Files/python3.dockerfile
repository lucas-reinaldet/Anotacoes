# Normalmente uma imagem Docker sempre é baseado em algo
# utilizando o comando FROM
FROM python:3.9.0-alpine

# Criador e Mantenedor da imagem
LABEL maintainer "Lucas Reinaldet <lucas.reinaldet@gmail.com>"

# Copiar todos os arquivos que se encontra no diretório onde se encontra o arquivo
# e envie para
COPY ./06-fusion_final /var/www

# Necessário especificar para definir o local onde os comandos serão executados.
WORKDIR /var/www/

# Executar comandos
RUN apk update 
RUN apk add zlib-dev jpeg-dev gcc musl-dev 
RUN pip install --upgrade pip

# Commando executado no WORKDIR depois que o container é executado.
ENTRYPOINT ["pip install -r requirements.txt", \
            "python manage.py migrate", \
            "python manage.py runserver 0.0.0.0:8000"]

# Exponha o serviço na porta 80
EXPOSE 8000