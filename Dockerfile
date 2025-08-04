FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    npm \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --upgrade pip && pip install -r requirements.txt

COPY package*.json ./
RUN npm install

COPY  . .

RUN npm run build

RUN python manage.py collectstatic --noinput

CMD ["gunicorn", "ecommerce.wsgi:application", "--bind", "0.0.0.0:8000"]
