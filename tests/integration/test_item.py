import pytest
import uuid

import app.api.v2.endpoints.item.crud as item_crud
import app.api.v2.endpoints.chest.crud as chest_crud
from app.api.v2.endpoints.item.schemas import ItemCreateSchema
from app.api.v2.endpoints.chest.schemas import ChestCreateSchema
from app.database.connection import SessionLocal


@pytest.fixture(scope='module')
def db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
        
def test_item_create_read_delete(db):
    new_item_name = 'test'
    new_item_description = 'test_description'
    number_of_items_before = len(item_crud.get_all_items(db))
    # Arrange: Instantiate a new item object
    item = ItemCreateSchema(name=new_item_name, description=new_item_description)
    # Act: Add item to database
    db_item = item_crud.create_item(item, db)
    created_item_id = db_item.id
    # Assert: One more item in database
    items = item_crud.get_all_items(db)
    assert len(items) == number_of_items_before + 1
    # Act: Re-read item from database
    read_item = item_crud.get_item_by_id(created_item_id, db)
    # Assert: Correct item was stored in database
    assert read_item.id == created_item_id
    assert read_item.name == new_item_name
    # Act: Re-read by name
    read_item = item_crud.get_item_by_name(new_item_name, db)
    # Assert: Correct item was stored in database
    assert read_item.id == created_item_id
    assert read_item.name == new_item_name
    # Act: Update item
    updated_item_name = 'test2'
    updated_item_description = 'test_description2'
    updated_item = ItemCreateSchema(name=updated_item_name, description=updated_item_description)
    item_crud.update_item(read_item, updated_item, db)
    # Assert: Correct item was updated in database
    updated_item = item_crud.get_item_by_id(created_item_id, db)
    assert updated_item.id == created_item_id
    assert updated_item.name == updated_item_name
    assert updated_item.description == updated_item_description
    # Arrange: Instantiate a new chest object
    new_chest_name = 'test_chest'
    new_chest_location = 'test_location'
    new_item_in_chest_anzahl = 10
    # Act: Add chest to database
    chest = ChestCreateSchema(name=new_chest_name, location=new_chest_location)
    db_chest = chest_crud.create_chest(chest, db)
    created_chest_id = db_chest.id
    # Act: Add item to chest
    chest_crud.add_item_to_chest(created_chest_id, created_item_id, new_item_in_chest_anzahl, db)
    # Assert: Correct item was added to chest
    full_chest = chest_crud.get_joined_items_by_chest_id(created_chest_id, db)
    assert len(full_chest) == 1
    assert full_chest[0].item_id == created_item_id
    assert full_chest[0].item.name == updated_item_name
    assert full_chest[0].item.description == updated_item_description
    assert full_chest[0].anzahl == new_item_in_chest_anzahl
    
    # Act: Delete item from chest
    chest_crud.delete_item_from_chest(created_chest_id, created_item_id, db)
    # Assert: Correct item was deleted from chest
    full_chest = chest_crud.get_joined_items_by_chest_id(created_chest_id, db)
    assert len(full_chest) == 0
    # Act: Delete chest
    chest_crud.delete_chest_by_id(created_chest_id, db)
    # Assert: Correct chest was deleted from database
    deleted_chest = chest_crud.get_chest_by_id(created_chest_id, db)
    assert deleted_chest is None
    
    # Act: Delete item
    item_crud.delete_item_by_id(created_item_id, db)
    # Assert: Correct number of items in database after deletion
    items = item_crud.get_all_items(db)
    assert len(items) == number_of_items_before
    # Assert: Correct item was deleted from database
    deleted_item = item_crud.get_item_by_id(created_item_id, db)
    assert deleted_item is None
    

# def test_update(db):
#     # Arrange: Instantiate a new dough object
#     new_dough_name = 'test'
#     new_dough_price = 10.0
#     new_dough_description = 'test_description'
#     new_dough_stock = 10
#     dough = DoughCreateSchema(name=new_dough_name, description=new_dough_description,
#                               stock=new_dough_stock, price=new_dough_price)
#     # Act: Add dough to database
#     db_dough = dough_crud.create_dough(dough, db)
#     dough = dough_crud.get_dough_by_id(db_dough.id, db)
#     number_of_doughs_before = len(dough_crud.get_all_doughs(db))
#     created_dough_id = db_dough.id
#     # Act: Update dough
#     updated_dough_name = 'test2'
#     updated_dough_price = 20.0
#     updated_dough_description = 'test_description2'
#     updated_dough_stock = 20
#     updated_dough = DoughCreateSchema(name=updated_dough_name, description=updated_dough_description,
#                                       stock=updated_dough_stock, price=updated_dough_price)
#     dough_crud.update_dough(dough, updated_dough, db)
#     # Assert: Correct dough was updated in database
#     updated_dough = dough_crud.get_dough_by_id(created_dough_id, db)
#     assert updated_dough.id == created_dough_id
#     assert updated_dough.name == updated_dough_name
#     assert updated_dough.price == updated_dough_price
#     assert updated_dough.description == updated_dough_description
#     # Act: Delete wrong dough id
#     wrong_dough_id = uuid.uuid4()
#     dough_crud.delete_dough_by_id(wrong_dough_id, db)
#     # Assert: Correct number of doughs in database after deletion
#     doughs = dough_crud.get_all_doughs(db)
#     assert len(doughs) == number_of_doughs_before
#     # Act: Delete dough
#     dough_crud.delete_dough_by_id(created_dough_id, db)
#     # Assert: Correct number of doughs in database after deletion
#     doughs = dough_crud.get_all_doughs(db)
#     assert len(doughs) == number_of_doughs_before - 1
#     # Assert: Correct dough was deleted from database
#     deleted_dough = dough_crud.get_dough_by_id(created_dough_id, db)
#     assert deleted_dough is None
