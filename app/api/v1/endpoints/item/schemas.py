from pydantic import BaseModel

class ItemBaseSchema(BaseModel):
    name: str
    description: str
    
    class Config:
        orm_mode = True
        
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
