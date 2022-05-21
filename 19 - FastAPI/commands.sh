
# Executar o projeto com o uvicorn
uvicorn main:app --reload

# Executar o projeto com o uvicorn setando algumas configurações
uvicorn main:app --host 0.0.0.0 --port 8900 --reload --workers 6 --limit-concurrency 500 --backlog 3000

# Executar o projeto usando o gunicorn (usado para por em produção devido
# ser mais parrudo) setando configurações de um arquivo.
gunicorn -c gunicorn.conf.py main:app