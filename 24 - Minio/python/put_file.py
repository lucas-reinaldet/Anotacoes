from minio_connection import client

client().fput_object(
        "pythonbucket", 
        "meudiretorio/titanic1.csv",
        "/home/ambientelivre/titanic1.csv",
    )

print("""
home/ambientelivre/titanic1.csv' carregado com sucesso
object 'titanic1.csv' to bucket 'pythonbucket'.
""")