# Use uma Imagem Official do Python
FROM python:3.9-slim

# Definindo o diretório onde a aplicação será armazenada
WORKDIR /app

# Copiar os arquivos da pasta local para dentro do container
COPY . /app

# Instalar as dependências de Python de acordo com o que foi desenvolvido na aplicação e que está declarado no arquivo requirements.txt.
RUN pip install --trusted-host pypi.python.org -r requirements.txt

ENV CLOUD_SQL_USERNAME $CLOUD_SQL_USERNAME
    CLOUD_SQL_PASSWORD $CLOUD_SQL_PASSWORD
    CLOUD_SQL_DATABASE_NAME $CLOUD_SQL_DATABASE_NAME
    CLOUD_SQL_CONNECTION_NAME $CLOUD_SQL_CONNECTION_NAME

# Instrução para iniciar a aplicação.
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 app:app
