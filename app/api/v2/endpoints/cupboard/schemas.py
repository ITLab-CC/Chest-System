from pydantic import BaseModel
from typing import List

class CupboardBaseModel(BaseModel):
    cupboard_name: str
    location: str
    
    class Config:
        orm_mode = True
        json_schema_extra = {
            "example": {
                "cupboard_name": "Cupboard Name",
                "location": "MakerSpace"
            }
        }
    
    
class CupboardSchema(CupboardBaseModel):
    id: int
    
class CupboardCreateSchema(CupboardBaseModel):
    pass

class CupboardChestQuantityCreateSchema(BaseModel):
    chest_id: int 

class CupboardChestQuantitySchema(CupboardChestQuantityCreateSchema):
    chest_name: str

class CupboardChestJoinedSchema(CupboardSchema):
    kistes: List[CupboardChestQuantitySchema]
    
    class Config:
        orm_mode = True