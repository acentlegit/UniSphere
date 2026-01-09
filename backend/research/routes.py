
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

