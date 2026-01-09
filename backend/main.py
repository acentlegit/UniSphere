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
