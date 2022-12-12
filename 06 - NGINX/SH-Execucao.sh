# Iniciar o serviço
sudo systemctl start nginx

# Serviço ser iniciado junto com o sistema
sudo systemctl enable nginx

# Parar o Serviço
sudo systemctl stop nginx

# não iniciar o serviço junto com o sistema
sudo systemctl disable nginx

# Reiniciar o serviço
## Aplicar configurações
sudo systemctl reload nginx

## Hard
sudo systemctl restart nginx


# Verificar pagina inicial
# sudo apt-get install curl
curl –i 127.0.0.1