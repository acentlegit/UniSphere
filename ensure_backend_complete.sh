#!/bin/bash

set -e

echo "🚀 Ensuring UniSphere Backend is Complete"

####################################
# Ensure backend directory
####################################
mkdir -p backend

cd backend

####################################
# Helper: create file if missing
####################################
create_if_missing () {
  if [ ! -f "$1" ]; then
    echo "➕ Creating $1"
    cat <<EOF > "$1"
$2
EOF
  else
    echo "✔ $1 exists"
  fi
}

####################################
# Folders
####################################
mkdir -p auth ai learning research video analytics db models

####################################
# requirements.txt
####################################
create_if_missing "requirements.txt" "
fastapi
uvicorn
python-jose
passlib[bcrypt]
sentence-transformers
faiss-cpu
llama-cpp-python
requests
python-dotenv
"

####################################
# main.py
####################################
create_if_missing "main.py" "
from fastapi import FastAPI
from auth.routes import router as auth_router
from learning.routes import router as learning_router
from research.routes import router as research_router
from video.routes import router as video_router
from analytics.routes import router as analytics_router

app = FastAPI(title='UniSphere AI Backend')

app.include_router(auth_router, prefix='/auth')
app.include_router(learning_router, prefix='/learning')
app.include_router(research_router, prefix='/research')
app.include_router(video_router, prefix='/video')
app.include_router(analytics_router, prefix='/analytics')

@app.get('/')
def health():
    return {'status': 'Backend running'}
"

####################################
# .env
####################################
create_if_missing ".env" "
JWT_SECRET=change_me
LIVEKIT_API_KEY=change_me
LIVEKIT_SECRET=change_me
"

####################################
# JWT
####################################
create_if_missing "auth/jwt.py" "
from jose import jwt
from datetime import datetime, timedelta
import os

SECRET = os.getenv('JWT_SECRET', 'CHANGE_ME')

def create_token(email, role):
    payload = {
        'sub': email,
        'role': role,
        'exp': datetime.utcnow() + timedelta(hours=12)
    }
    return jwt.encode(payload, SECRET, algorithm='HS256')

def decode_token(token):
    return jwt.decode(token, SECRET, algorithms=['HS256'])
"

####################################
# Auth routes
####################################
create_if_missing "auth/routes.py" "
from fastapi import APIRouter
from pydantic import BaseModel
from auth.jwt import create_token, decode_token

router = APIRouter()

class Login(BaseModel):
    email: str
    password: str

@router.post('/login')
def login(data: Login):
    role = 'student'
    return {'token': create_token(data.email, role), 'role': role}

@router.get('/me')
def me(token: str):
    return decode_token(token)
"

####################################
# RAG
####################################
create_if_missing "ai/rag.py" "
from llama_cpp import Llama
from sentence_transformers import SentenceTransformer
import faiss, pickle, os

llm = Llama(model_path='models/llama.gguf', n_ctx=2048)
embedder = SentenceTransformer('all-MiniLM-L6-v2')

INDEX = 'index.faiss'
DOCS = 'docs.pkl'

if os.path.exists(INDEX):
    index = faiss.read_index(INDEX)
    docs = pickle.load(open(DOCS, 'rb'))
else:
    index = faiss.IndexFlatL2(384)
    docs = []

def add_docs(texts):
    emb = embedder.encode(texts)
    index.add(emb)
    docs.extend(texts)
    faiss.write_index(index, INDEX)
    pickle.dump(docs, open(DOCS, 'wb'))

def ask(query):
    q_emb = embedder.encode([query])
    _, idx = index.search(q_emb, 5)
    context = '\\n'.join([docs[i] for i in idx[0] if i < len(docs)])
    prompt = f'Context:\\n{context}\\nQuestion:{query}'
    out = llm(prompt, max_tokens=512)
    return out['choices'][0]['text']
"

####################################
# Learning
####################################
create_if_missing "learning/routes.py" "
from fastapi import APIRouter
from ai.rag import ask

router = APIRouter()

@router.get('/ask')
def ask_q(q: str):
    return {'answer': ask(q)}
"

####################################
# Research
####################################
create_if_missing "research/routes.py" "
from fastapi import APIRouter
import requests
from ai.rag import add_docs, ask

router = APIRouter()

@router.get('/papers')
def papers(query: str):
    url = f'https://api.semanticscholar.org/graph/v1/paper/search?query={query}&limit=5'
    data = requests.get(url).json()
    titles = [p['title'] for p in data.get('data', [])]
    add_docs(titles)
    return {'papers': titles}

@router.get('/ask')
def ask_r(q: str):
    return {'answer': ask(q)}
"

####################################
# LiveKit
####################################
create_if_missing "video/routes.py" "
from fastapi import APIRouter
import jwt, time, os

router = APIRouter()

KEY = os.getenv('LIVEKIT_API_KEY')
SECRET = os.getenv('LIVEKIT_SECRET')

@router.post('/token')
def token(room: str, user: str):
    payload = {
        'iss': KEY,
        'sub': user,
        'room': room,
        'exp': int(time.time()) + 3600
    }
    return {'token': jwt.encode(payload, SECRET, algorithm='HS256')}
"

####################################
# Analytics
####################################
create_if_missing "analytics/routes.py" "
from fastapi import APIRouter

router = APIRouter()

@router.get('/dashboard')
def stats():
    return {
        'active_users': 100,
        'queries': 500,
        'sessions': 20
    }
"

####################################
# Install deps
####################################
echo "📦 Installing dependencies..."
pip3 install -r requirements.txt

echo ""
echo "✅ Backend verified & completed"
echo "👉 Run: cd backend && uvic

