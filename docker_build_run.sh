#!/bin/bash

set -e

echo "🚀 Building UniSphere AI – Docker Full Stack (Bulletproof Mode)"

####################################
# Ensure backend exists
####################################
if [ ! -d "backend" ]; then
  echo "❌ backend/ not found. Run ensure_backend_complete.sh first."
  exit 1
fi

####################################
# Ensure frontend exists
####################################
if [ ! -d "frontend" ]; then
  echo "📁 frontend/ missing — creating minimal React app..."
  npx create-react-app frontend
fi

####################################
# Ensure Dockerfile paths exist
####################################
mkdir -p backend frontend

####################################
# BACKEND DOCKERFILE
####################################
echo "🐍 Writing backend Dockerfile..."
cat <<EOF > backend/Dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PYTHONUNBUFFERED=1

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
EOF

####################################
# FRONTEND DOCKERFILE
####################################
echo "⚛️ Writing frontend Dockerfile..."
cat <<EOF > frontend/Dockerfile
FROM node:18 AS build

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

FROM node:18
WORKDIR /app
RUN npm install -g serve
COPY --from=build /app/build ./build

EXPOSE 3000
CMD ["serve", "-s", "build", "-l", "3000"]
EOF

####################################
# DOCKER COMPOSE
####################################
echo "🐳 Writing docker-compose.yml..."
cat <<EOF > docker-compose.yml
version: "3.9"

services:
  backend:
    build: ./backend
    container_name: unisphere-backend
    ports:
      - "8000:8000"
    env_file:
      - backend/.env
    restart: unless-stopped

  frontend:
    build: ./frontend
    container_name: unisphere-frontend
    ports:
      - "3000:3000"
    depends_on:
      - backend
    restart: unless-stopped
EOF

####################################
# BUILD & RUN
####################################
echo "🐳 Building Docker images..."
docker compose build

echo "▶️ Starting containers..."
docker compose up -d

echo ""
echo "✅ UniSphere AI is RUNNING"
echo "🌐 Frontend: http://localhost:3000"
echo "🔌 Backend:  http://localhost:8000"

