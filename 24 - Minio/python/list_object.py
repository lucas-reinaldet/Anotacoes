from minio_connection import client

# Lista todos objetos com seus diretórios do bucket
objects = client().list_objects('pythonbucket', prefix='',
                              recursive=True)
for obj in objects:
    print(f"\nBucket: {obj.bucket_name}, Objeto: {obj.object_name.encode('utf-8')}, Ultima modificação {obj.last_modified}, Chave Primaria: {obj.etag}, Tamanho {obj.size}bytes, Content Type: {obj.content_type}")