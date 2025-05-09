FROM oraclelinux:9

# Instalar o Oracle Instant Client e outras dependências
RUN dnf -y install oracle-instantclient-release-el9 && \
    dnf -y install oracle-instantclient19.19-basic && \
    dnf -y install oracle-instantclient19.19-devel && \
    dnf -y install stunnel && \
    dnf -y install make gcc gcc-c++ openssl zlib openssl-devel zlib-devel wget unzip && \
    rm -rf  /var/cache/dnf

# Instalar o Node.js
RUN curl -fsSL https://rpm.nodesource.com/setup_20.x | bash - && \
    dnf install -y nodejs

# Configurar variáveis de ambiente para o Oracle
ENV LD_LIBRARY_PATH="/usr/lib/oracle/19.19/client64/lib"
ENV OCI_HOME="/usr/lib/oracle/19.19/client64/lib"
ENV OCI_LIB_DIR="/usr/lib/oracle/19.19/client64/lib"
ENV OCI_VERSION="19.19"

# Definir diretório de trabalho
WORKDIR /home/node/app

# Copiar arquivos de dependências
COPY package*.json tsconfig.json ./

# Instalar dependências do npm
RUN npm install

# Copiar o restante do código da aplicação
COPY . .

# List files for debugging
RUN ls -la

# Compilar o código TypeScript
RUN npm run build

# Expor a porta da aplicação
EXPOSE 3000

# Iniciar a aplicação
CMD ["npm", "start"]