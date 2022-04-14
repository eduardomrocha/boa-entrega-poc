import logging

from fastapi import FastAPI

from app.database.database_session import global_init
from app.routers import entregas, status

log = logging.getLogger("uvicorn")


def create_application() -> FastAPI:
    application = FastAPI()
    application.include_router(status.router, prefix="")
    application.include_router(entregas.router, prefix="")
    return application


app = create_application()


@app.on_event("startup")
async def startup_event():
    log.info("Starting up...")
    global_init()
