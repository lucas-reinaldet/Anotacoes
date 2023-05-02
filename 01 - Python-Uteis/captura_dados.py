from scapy.all import *
import docker

client = docker.from_env()

# Define a função para capturar os pacotes de dados
def packet_callback(packet):
    if packet.haslayer(IP):
        src_ip = packet[IP].src
        dst_ip = packet[IP].dst
        print("Pacote de dados capturado:")
        print("Origem: ", src_ip)
        print("Destino: ", dst_ip)

# Cria um objeto para capturar os pacotes de dados
sniff_thread = AsyncSniffer(prn=packet_callback)

# Inicia a captura dos pacotes de dados
sniff_thread.start()

# Lista todos os containers do Docker
containers = client.containers.list()

for container in containers:
    print("Container:", container.name)
    # Obtém o ID do container
    container_id = container.id
    
    # Obtém a interface de rede do container
    container_network = client.containers.get(container_id).attrs['NetworkSettings']['Networks'].keys()[0]
    
    # Adiciona a interface de rede do container à captura de pacotes de dados
    sniff_thread.add_filter('src host ' + container_network)
    sniff_thread.add_filter('dst host ' + container_network)
    
# Aguarda a captura dos pacotes de dados por 60 segundos
time.sleep(60)

# Para a captura dos pacotes de dados
sniff_thread.stop()