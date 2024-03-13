
from pydantic import BaseModel
from typing import List

class ChestBaseSchema(BaseModel):
    name: str
    location: str
    
    class Config:
        orm_mode = True
        json_schema_extra = {
            "example": {
                "name": "Chest Name",
                "location": "Left side of the room"
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
