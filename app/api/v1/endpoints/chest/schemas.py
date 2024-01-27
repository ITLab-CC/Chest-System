
from pydantic import BaseModel


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