import os

from app.config import Settings, get_settings
from app.database.database_session import get_db
from fastapi import APIRouter, Depends

router = APIRouter()
APP_VERSION = os.getenv("APP_VERSION", "1.0.0")


@router.get("/status")
async def status(settings: Settings = Depends(get_settings)):
    return {
        "version": APP_VERSION,
        "environment": settings.environment,
        "testing": settings.testing,
    }
