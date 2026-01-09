#!/bin/bash

set -e

echo "🚀 Completing UniSphere Backend (Auto-Fix Mode)"

####################################
# Create backend structure
####################################
mkdir -p backend/{auth,ai,learning,research,video,analytics,db}

cd backend

####################################
# requirements.txt
####################################
cat <<EOF > requirements.txt
fastapi
uvicorn
python-jose
passlib[bcrypt]
sentence-transformers
faiss-cpu
llama-cpp-python
requests
python-dotenv
EOF

####################################
# main.py
####################################
cat <<EOF > main.py
from fastapi import FastAPI
from auth.routes import router as auth_router
from learning.routes import router as learning_router
from research.routes import router as research_router
from video.routes import router as video_router
from analytics.routes import router as analytics_router

app = FastAPI(title="UniSphere AI Backend")

app.include_router(auth_router, prefix="/auth")
app.include_router(learning_router, prefix="/learning")
app.include_router(research_router, prefix="/research")
app.include_router(video_router, prefix="/video")
app.include_router(analytics_router, prefix="/analytics")

@app.get("/")
def health():
    return {"status": "UniSphere Backend Running"}
EOF

####################################
# JWT AUTH
####################################
cat <<EOF > auth/jwt.py
from jose import jwt
from datetime import datetime, timedelta
import os

SECRET = os.getenv("JWT_SECRET", "CHANGE_ME")

def create_token(email, role):
    payload = {
        "sub": email,
        "role": role,
        "exp": datetime.utcnow() + timedelta(hours=12)
    }
    return jwt.encode(payload, SECRET, algorithm="HS256")

def decode_token(token):
    return jwt.decode(token, SECRET, algorithms=["HS256"])
EOF

cat <<EOF > auth/routes.py
from fastapi import APIRouter
from pydantic import BaseModel
from auth.jwt import create_token, decode_token

router = APIRouter()

class Login(BaseModel):
    email: str
    password: str

@router.post("/login")
def login(data: Login):
    role = "student"
    return {"token": create_token(data.email, role), "role": role}

@router.get("/me")
def me(token: str):
    return decode_token(token)
EOF

####################################
# LLaMA + FAISS RAG
####################################
cat <<EOF > ai/rag.py
from llama_cpp import Llama
from sentence_transformers import SentenceTransformer
import faiss, pickle, os

llm = Llama(model_path="models/llama.gguf", n_ctx=2048)
embedder = SentenceTransformer("all-MiniLM-L6-v2")

INDEX = "index.faiss"
DOCS = "docs.pkl"

if os.path.exists(INDEX):
    index = faiss.read_index(INDEX)
    docs = pickle.load(open(DOCS, "rb"))
else:
    index = faiss.IndexFlatL2(

