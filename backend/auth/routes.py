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
