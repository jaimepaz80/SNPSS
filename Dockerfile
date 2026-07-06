# Capa base ligera y optimizada
FROM python:3.11-slim

# Evitar la creación de archivos .pyc y forzar salida estándar (streaming)
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Directorio de trabajo del contenedor
WORKDIR /app

# Instalar dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el código fuente y el frontend
COPY App.py .
COPY index.html .

# Cloud Run inyecta automáticamente la variable de entorno $PORT
# Configuración Gunicorn: 1 worker, 8 threads para streaming simultáneo, sin timeout preventivo
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 App:app
