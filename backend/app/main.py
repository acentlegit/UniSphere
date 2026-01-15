
from fastapi import FastAPI
from .ethics_agent import EthicsAgent

app = FastAPI()

@app.get("/student/progress")
def student_progress():
    return {"completion": 75, "course": "AI Fundamentals"}

@app.get("/coach/flags")
def coach_flags():
    return {"pending": 3}

@app.post("/ai/generate")
def ai_generate(prompt: str):
    agent = EthicsAgent()
    agent.pre_check(prompt)
    return {"response": "AI-generated answer"}
