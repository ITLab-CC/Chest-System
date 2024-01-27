
from pydantic import BaseModel
from app.api.v1.endpoints.item.schemas import ItemBaseSchema

class ChestBaseSchema(BaseModel):
    name: str

    class Config:
        orm_mode = True
        
class ChestCreateSchema(ChestBaseSchema):
    pass

class ChestSchema(ChestBaseSchema):
    id: int
    
class ChestUpdateSchema(ChestBaseSchema):
    pass

class ChestListItemSchema(BaseModel):
    id: int
    name: str
    
    class Config:
        orm_mode = True
        
class ChestItemQuantityBaseSchema(BaseModel):
    anzahl: int
    
    class Config:
        orm_mode = True
        
class ChestItemCreateSchema(ChestItemQuantityBaseSchema):
    item_id: int        

class JoinedChestItemSchema(ChestBaseSchema, ItemBaseSchema):
    pass