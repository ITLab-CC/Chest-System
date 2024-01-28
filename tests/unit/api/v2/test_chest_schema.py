from app.api.v2.endpoints.chest.schemas import ChestSchema, ChestBaseSchema, ChestCreateSchema
from app.api.v2.endpoints.chest.schemas import JoinedChestItemSchema, ChestItemCreateSchema
from typing import List

def test_chest_base_schema():
    chest = ChestBaseSchema(name='test')
    assert hasattr(chest, 'name')
    assert not hasattr(chest, 'id')
    
def test_chest_schema():
    chest = ChestSchema(id=1, name='test')
    assert hasattr(chest, 'name')
    assert hasattr(chest, 'id')
    
def test_chest_create_schema():
    chest = ChestCreateSchema(name='test')
    assert hasattr(chest, 'name')
    assert not hasattr(chest, 'id')
    
def test_joined_chest_item_schema():
    chest = JoinedChestItemSchema()
    assert hasattr(chest, 'name')
    assert hasattr(chest, 'id')
    assert hasattr(chest, 'items')
    assert isinstance(chest.items, List)