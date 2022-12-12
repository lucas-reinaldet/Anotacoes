
# Verificar se o serviço esta liberado pelo firewall.
sudo ufw app list

# Adicionar permissão ao nginx no trafego http
sudo ufw allow 'nginx http'

# Adicionar permissão para  o trafego https
sudo ufw allow 'nginx https'

# Adicionar permissão para trafegar em ambos
sudo ufw allow 'nginx full'

# Observação: é recomendável permitir apenas o tráfego mínimo necessário pelo firewall. 
# Para este processo, apenas o tráfego HTTP básico é necessário. Outras configurações 
# podem exigir HTTPS (criptografado) ou outro tráfego. Se o sistema usar um firewall 
# diferente, ele deve ser configurado para permitir tráfego na porta 80 (HTTP), 
# porta 443 (HTTPS) ou em qualquer outra porta exigida pela rede.

# Aplicar modificações do firewall
sudo ufw reload

