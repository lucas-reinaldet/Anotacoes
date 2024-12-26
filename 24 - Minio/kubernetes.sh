# Minikube serve para levantar o ambiente kubernetes local para aprendizado e o
# desenvolvimento do kubernetes

mkdir /home/ambientelivre/hacks

cd /home/ambientelivre/hacks

curl https://raw.githubusercontent.com/ambientelivre/samples_minio/main/deploy/k8s/minio-standalone-deployment.yaml -O


curl https://raw.githubusercontent.com/ambientelivre/samples_minio/main/deploy/k8s/minio-standalone-pvc.yaml -O

ls

# minio-standalone-deployment.yaml
# minio-standalone-pvc.yaml

minikube start

# result:
# 😄  minikube v1.27.1 on Debian 11.5 (vbox/amd64)
# ✨  Using the docker driver based on existing profile
# 👍  Starting control plane node minikube in cluster minikube
# 🚜  Pulling base image ...
# 🔄  Restarting existing docker container for "minikube" ...
# 🎉  minikube 1.31.2 is available! Download it: https://github.com/kubernetes/minikube/releases/tag/v1.31.2
# 💡  To disable this notice, run: 'minikube config set WantUpdateNotification false'

# 🐳  Preparing Kubernetes v1.25.2 on Docker 20.10.18 ...
# 🔎  Verifying Kubernetes components...
#     ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
#     ▪ Using image docker.io/kubernetesui/metrics-scraper:v1.0.8
#     ▪ Using image docker.io/kubernetesui/dashboard:v2.7.0
# 🌟  Enabled addons: storage-provisioner, default-storageclass, dashboard
# 💡  kubectl not found. If you need it, try: 'minikube kubectl -- get pods -A'
# 🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default

# Lista serviços
minikube kubectl -- get pods

# Lista os PVC - discos / volume
minikube kubectl -- get pvc

# Script para criar um PVC no kubernetes
minikube kubectl -- apply -f minio-standalone-pvc.yaml

# Agenda a criação e inicia o container
minikube kubectl -- apply -f minio-standalone-deployment.yaml

docker inspec minikube 
# < Procurar pelo ip andress >
# Verificar o acesso via browser do minio

# Editar o arquivo
minikube kubectl -- edit deployments minio-deployment

