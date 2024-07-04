from pydantic import BaseModel
from typing import List

class AuditLogBase(BaseModel):
    timestamp: str
    request: str
    response: str
    user: str
    ip: str
    status_code: int
    
    class Config:
        orm_mode = True
        json_schema_extra = {
            "example": {
                "timestamp": "2021-01-01 12:00:00",
                "request": "GET /api/v2/chest",
                "response": "200 OK",
                "user": "admin",
                "ip": "192.168.1.10",
                "status_code": 200
            }
        }
        
class AuditLogCreate(AuditLogBase):
    pass

class AuditLog(AuditLogBase):
    id: int
    
class AuditLogList(BaseModel):
    audit_logs: List[AuditLog]
    
    class Config:
        orm_mode = True
                