# Usa uma imagem oficial do Python, bem leve
FROM python:3.12-slim

# Atualiza pacotes do sistema operacional para mitigar CVEs da imagem base
RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia apenas o arquivo de dependências primeiro (otimização de cache)
COPY requirements.txt .

# Instala as dependências
RUN pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r requirements.txt

# Copia o resto do código da aplicação
COPY . .

# Expõe a porta 5000
EXPOSE 5000

# Comando para rodar a aplicação quando o contêiner iniciar
CMD ["python", "app.py"]