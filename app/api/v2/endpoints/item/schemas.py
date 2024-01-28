from pydantic import BaseModel
from typing import List

class ItemBaseSchema(BaseModel):
    name: str
    description: str
    
    class Config:
        orm_mode = True
        json_schema_extra = {
            "example": {
                "name": "Item Name",
                "description": "Item Description"
            }
        }
        
        
        
class ItemCreateSchema(ItemBaseSchema):

    pass
    
    
    
class ItemSchema(ItemBaseSchema):
    id: int
    
class ItemUpdateSchema(ItemBaseSchema):
    pass

class ItemListItemSchema(ItemBaseSchema):
    id: int
    name: str
    description: str
    
    class Config:
        orm_mode = True
        
class ItemListItemSchema(BaseModel):
    id: int
    name: str
    description: str
    
    class Config:
        orm_mode = True

class ItemChestQuantityCreateSchema(BaseModel):
    kiste_id: int      
    anzahl: int

    class Config:
        orm_mode = True
        
class ItemChestQuantitySchema(ItemChestQuantityCreateSchema):
    kiste_name: str
    
    class Config:
        orm_mode = True

class ItemChestJoinedSchema(ItemSchema):
    chests: List[ItemChestQuantitySchema]
    
    class Config:
        orm_mode = True