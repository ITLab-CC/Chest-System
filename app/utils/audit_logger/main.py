from app.utils.audit_logger.schemas import AuditLogCreate
from fastapi import FastAPI, Request, status, Depends
from fastapi.responses import JSONResponse
from app.database.connection import SessionLocal
from app.database.models import AuditLog
from time import time
from sqlalchemy.orm import Session
import logging

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

class AuditLogger:
    def __init__(self):
        pass

    async def log_request(self, request: Request, response: status, user: str = "unknown"):
        try:
            db = next(get_db())
            client_host = request.client.host
            ip_behind_proxy_1 = request.headers.get('X-Forwarded-For') # The proxy in this Project
            if ip_behind_proxy_1:
                client_host = ip_behind_proxy_1
            ip_behind_proxy_2 = request.headers.get('X-Forwarded-Forr') # Maybe another proxy (Like Traefik)
            if ip_behind_proxy_2:
                client_host = ip_behind_proxy_2
            request = {
                'method': request.method,
                'url': request.url._url,
                'headers': dict(request.headers),
            }
            response = {
                'status_code': response.status_code,
                'headers': dict(response.headers),
            }
            log_create = AuditLogCreate(
                timestamp=str(time()),
                request=str(request),
                response=str(response),
                user=user,
                ip=client_host,
                status_code=response['status_code']
            )
            audit_log = AuditLog(**log_create.dict())
            db.add(audit_log)
            db.commit()
        except Exception as e:
            logging.error(f"Error logging request: {e}")
            return JSONResponse(status_code=500, content={'message': 'Internal server error'})