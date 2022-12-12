# No Nginx, um bloco de servidor é uma configuração que funciona como seu próprio servidor. 
# Por padrão, o Nginx tem um bloco de servidor pré-configurado.

# Ele está localizado em /var/www/html . No entanto, ele pode ser configurado com vários 
# blocos de servidor para sites diferentes.

# Diretorio para o dominio
sudo mkdir -p /var/www/test_domain.com/html

# Use chmod para configurar regras de propriedade e permissão:
sudo chown -R $USER:$USER /var/www/test_domain.com
sudo chmod -R 755 /var/www/test_domain.com

# Criar arquivo html
echo '''
<html>
   <head>
      <title>Welcome to test_domain.com!</title>
   </head>
   <body>
      <h1>This message confirms that your Nginx server block is working. Great work!</h1>
   </body>
</html>
''' > /var/www/test_domain.com/html/index.html

# Configuração do bloco
# Editar o arquivo
sudo nano /etc/nginx/sites-available/test_domain.com

# ->

server    {
listen 80;
 
root /var/www/test_domain.com/html;
index index.html index.htm index.nginx.debian.html;
 
server_name test_domain.com www.test_domain.com;
location /          {
try_files $uri $uri/ =404;
      }
}

# <-

# Criar um link simbolico entre o bloco e o diretorio de inicialização para o nginx
sudo ln -s /etc/nginx/sites-available/test_domain.com /etc/nginx/sites-enabled

# Reiniciar o serviço
sudo systemctl restart nginx

# Testar configuração
sudo nginx -t