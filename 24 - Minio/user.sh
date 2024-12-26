
# Criando user atraves da interface Gráfica


# Criando Policy

nome: financeiro

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetBucketLocation",
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::*"
            ]
        }
    ]
}




# Conectando com um cliente especifico
mc alias set financeiro http://127.0.0.1:9000 cordenador cordenador

# remover um alias
mc alias remove financeiro

# # Criando o alias setando o bucket especifico
# mc alias set financeiro http://127.0.0.1:9000 cordenador cordenador
# Não funcionou
# nano .mc/config.json
# "aliases": {
#                 "financeiro": {
#                         "url": "http://127.0.0.1:9000",
#                         "accessKey": "cordenador",
#                         "secretKey": "cordenador",
#                         "api": "s3v4",
#                         "path": "auto"
#                 },
# [...]
#


