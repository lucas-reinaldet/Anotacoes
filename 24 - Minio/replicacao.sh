
# Criar as pastas
mkdir /home/ambientelivre/mnt
mkdir /home/ambientelivre/mnt/diskdata1
mkdir /home/ambientelivre/mnt/diskdata2
mkdir /home/ambientelivre/mnt/diskdata3
mkdir /home/ambientelivre/mnt/diskdata4


# Iniciar ele com forma de parametros
minio server /home/ambientelivre/mnt/diskdata{1...4} --console-address :9090


# Exemplo de retyorno:
# PI: SYSTEM()
# Time: 12:13:14 UTC 10/05/2023
# Error: Drive `/home/ambientelivre/mnt/diskdata4` is part of root drive, will not be used (*errors.errorString)
#        8: internal/logger/logger.go:259:logger.LogIf()
#        7: cmd/erasure-sets.go:1247:cmd.markRootDisksAsDown()
#        6: cmd/format-erasure.go:800:cmd.initFormatErasure()
#        5: cmd/prepare-storage.go:198:cmd.connectLoadInitFormats()
#        4: cmd/prepare-storage.go:302:cmd.waitForFormatErasure()
#        3: cmd/erasure-server-pool.go:109:cmd.newErasureServerPools()
#        2: cmd/server-main.go:700:cmd.newObjectLayer()
#        1: cmd/server-main.go:525:cmd.serverMain()
# ERROR Unable to initialize backend: drive not found


docker run \
    -p 9011:9000 \
    -p 9021:9090 \
    --name minio1 \
    -v ~/mnt/diskdata1:/data \
    -e "MINIO_ROOT_USER=minioadmin" \
    -e "MINIO_ROOT_PASSWORD=minioadmin" \
    quay.io/minio/minio server /data --console-address ":9090"

# API -> 9011
# INTERFACE -> 9021

docker run \
    -p 9012:9000 \
    -p 9022:9090 \
    --name minio2 \
    -v ~/mnt/diskdata2:/data \
    -e "MINIO_ROOT_USER=minioadmin" \
    -e "MINIO_ROOT_PASSWORD=minioadmin" \
    quay.io/minio/minio server /data --console-address ":9090"

# API -> 9012
# INTERFACE -> 9022

docker run \
    -p 9013:9000 \
    -p 9023:9090 \
    --name minio3 \
    -v ~/mnt/diskdata3:/data \
    -e "MINIO_ROOT_USER=minioadmin" \
    -e "MINIO_ROOT_PASSWORD=minioadmin" \
    quay.io/minio/minio server /data --console-address ":9090"

# API -> 9013
# INTERFACE -> 9023

docker run \
    -p 9014:9000 \
    -p 9024:9090 \
    --name minio4 \
    -v ~/mnt/diskdata4:/data \
    -e "MINIO_ROOT_USER=minioadmin" \
    -e "MINIO_ROOT_PASSWORD=minioadmin" \
    quay.io/minio/minio server /data --console-address ":9090"

# API -> 9013
# INTERFACE -> 9023

# Site da MinIO - Documentação sobre Replication
# https://min.io/docs/minio/linux/operations/install-deploy-manage/multi-site-replication.html?ref=con


# Na interface gráfica, deve-se acessar o menu "Site Replication"
# e ali deve-se fazer as configurações necessárias para a conexão
# entre os minios.

# Atraves do comando mc

mc alias set minio1 http://172.17.0.2:9000 minioadmin minioadmin
mc alias set minio2 http://172.17.0.3:9000 minioadmin minioadmin
mc alias set minio3 http://172.17.0.4:9000 minioadmin minioadmin
mc alias set minio4 http://172.17.0.5:9000 minioadmin minioadmin

#
mc admin replicate add minio1 minio2 minio3 minio4

# mc admin replicate add minio1/teste1 --remote-bucket minio4/teste1 --priority 1

# Comando para forçar a replicação

mc admin replicate resync start minio1 minio3


# rmeovendo
mc admin replicate remove minio3 --all --force

# Sincronização entre MinIO
mc mirror minio1/teste1 minio2/teste1

# Sincronização entre Buckets
mc mirror minio1/teste1 minio1/teste2