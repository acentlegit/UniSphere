
from fastapi import APIRouter
from ai.rag import ask

router = APIRouter()

@router.get('/ask')
def ask_q(q: str):
    return {'answer': ask(q)}

