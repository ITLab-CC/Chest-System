
from pydantic import BaseModel
from typing import List

class ChestBaseSchema(BaseModel):
    name: str

    class Config:
        orm_mode = True
        
class ChestCreateSchema(ChestBaseSchema):
    pass

class ChestSchema(ChestBaseSchema):
    id: int


        
class ChestItemQuantityCreateSchema(BaseModel):
    item_id: int        
    anzahl: int

    class Config:
        orm_mode = True
    
class ChestItemJoinedSchema(ChestSchema):
    items: List[ChestItemQuantityCreateSchema]
    
    class Config:
        orm_mode = True
