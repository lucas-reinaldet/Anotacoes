from minio.error import S3Error
from minio_connection import client


# Realiza download de objetos para diretorio local
try:
    client().fget_object('pythonbucket', 'meudiretorio/titanic1.csv', 'minio_download/titanic1.csv')
except S3Error as err:
    print(err)