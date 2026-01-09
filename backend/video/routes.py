
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

