
from fastapi import APIRouter

router = APIRouter()

@router.get('/dashboard')
def stats():
    return {
        'active_users': 100,
        'queries': 500,
        'sessions': 20
    }

