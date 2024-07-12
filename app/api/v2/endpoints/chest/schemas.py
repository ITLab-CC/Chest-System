from pydantic import BaseModel
from typing import List, Optional

class ChestBaseSchema(BaseModel):
    name: str
    cupboard_id: int | None = None # Optional
    
    class Config:
        orm_mode = True
        json_schema_extra = {
            "example": {
                "name": "Chest Name",
                "cupboard_id": None
            }
        }
        
class ChestCreateSchema(ChestBaseSchema):
    pass

class ChestSchema(ChestBaseSchema):
    id: int


        
class ChestItemQuantityCreateSchema(BaseModel):
    item_id: int 
    # item_name: str
           
    anzahl: int

    class Config:
        orm_mode = True
        
class ChestItemQuantitySchema(ChestItemQuantityCreateSchema):
    item_name: str
    
class ChestItemJoinedSchema(ChestSchema):
    items: List[ChestItemQuantitySchema]
    
    class Config:
        orm_mode = True
