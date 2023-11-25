# Use uma Imagem Official do Python
FROM python:3

# Adicionando um usuário de sistema
RUN adduser --system --home /home/myapp  myapp
USER myapp

# Definindo o diretório onde a aplicação será armazenada
WORKDIR /home/myapp

#Definindo o local onde o binário do gunicorn é instalado
ENV PATH="/home/myapp/.local/bin:${PATH}"

# Copiar os arquivos da pasta local para dentro do container
COPY --chown=myapp:nogroup --chmod=644 ./app.py ./db.py ./requirements.txt /home/myapp

# Instalar as dependências de Python de acordo com o que foi desenvolvido na aplicação e que está declarado no arquivo requirements.txt.
RUN pip install --user --trusted-host pypi.python.org -r requirements.txt

# Instrução para iniciar a aplicação.
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 app:app