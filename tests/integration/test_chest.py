import pytest
import uuid

import app.api.v1.endpoints.chest.crud as chest_crud
import app.api.v1.endpoints.item.crud as item_crud
from app.api.v1.endpoints.chest.schemas import ChestCreateSchema
from app.api.v1.endpoints.item.schemas import ItemCreateSchema
from app.database.connection import SessionLocal


@pytest.fixture(scope='module')
def db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
        
def test_chest_create_read_delete(db):
    new_chest_name = 'test'
    number_of_chests_before = len(chest_crud.get_all_chests(db))
    # Arrange: Instantiate a new chest object
    chest = ChestCreateSchema(name=new_chest_name)
    # Act: Add chest to database
    db_chest = chest_crud.create_chest(chest, db)
    created_chest_id = db_chest.id
    # Assert: One more chest in database
    chests = chest_crud.get_all_chests(db)
    assert len(chests) == number_of_chests_before + 1
    # Act: Re-read chest from database
    read_chest = chest_crud.get_chest_by_id(created_chest_id, db)
    # Assert: Correct chest was stored in database
    assert read_chest.id == created_chest_id
    assert read_chest.name == new_chest_name
    # Act: Re-read by name
    read_chest = chest_crud.get_chest_by_name(new_chest_name, db)
    # Assert: Correct chest was stored in database
    assert read_chest.id == created_chest_id
    assert read_chest.name == new_chest_name
    
    # Add item to chest
    # Arrange: Instantiate a new item object
    new_item_name = 'test'
    new_item_description = 'test_description'
    new_item_quantity = 1
    # Act: Add item to database
    item = ItemCreateSchema(name=new_item_name, description=new_item_description)
    db_item = item_crud.create_item(item, db)
    created_item_id = db_item.id
    # Act: Add item to chest
    chest_crud.add_item_to_chest(created_chest_id, created_item_id, new_item_quantity, db)
    # Assert: Correct item was added to chest
    items = chest_crud.get_joined_items_by_chest_id(created_chest_id, db)
    assert len(items) == 1
    assert items[0].kiste_id == created_chest_id
    assert items[0].item_id == created_item_id
    assert items[0].anzahl == new_item_quantity
    # Act: Add item to chest again
    chest_crud.add_item_to_chest(created_chest_id, created_item_id, new_item_quantity, db)
    # Assert: Correct item was added to chest
    items = chest_crud.get_joined_items_by_chest_id(created_chest_id, db)
    assert len(items) == 1
    assert items[0].kiste_id == created_chest_id
    assert items[0].item_id == created_item_id
    assert items[0].anzahl == new_item_quantity * 2
    # Act: Update item quantity in chest
    new_item_quantity = 3
    chest_crud.update_item_in_chest(created_chest_id, created_item_id, new_item_quantity, db)
    # Assert: Correct item was updated in chest
    items = chest_crud.get_joined_items_by_chest_id(created_chest_id, db)
    assert len(items) == 1
    assert items[0].kiste_id == created_chest_id
    assert items[0].item_id == created_item_id
    assert items[0].anzahl == new_item_quantity
    
    # Act: Remove item from chest
    chest_crud.delete_item_from_chest(created_chest_id, created_item_id, db)
    # Assert: Correct item was removed from chest
    items = chest_crud.get_joined_items_by_chest_id(created_chest_id, db)
    assert len(items) == 0
    # Act: Remove item from chest again
    chest_crud.delete_item_from_chest(created_chest_id, created_item_id, db)
    # Assert: Correct item was removed from chest
    items = chest_crud.get_joined_items_by_chest_id(created_chest_id, db)
    assert len(items) == 0
    # Act: Delete item
    item_crud.delete_item_by_id(created_item_id, db)
    # Assert: Correct item was deleted from database
    deleted_item = item_crud.get_item_by_id(created_item_id, db)
    assert deleted_item is None
    # Update chest item quantity for non-existing item
    result = chest_crud.update_item_in_chest(created_chest_id, created_item_id, new_item_quantity, db)
    assert result is None
    
    # Update chest
    updated_chest_name = 'test2'
    # Act: Update chest
    updated_chest = ChestCreateSchema(name=updated_chest_name)
    chest_crud.update_chest(read_chest, updated_chest, db)
    # Assert: Correct chest was updated in database
    updated_chest = chest_crud.get_chest_by_id(created_chest_id, db)
    assert updated_chest.id == created_chest_id
    assert updated_chest.name == updated_chest_name
    
    
    
    # Act: Delete chest
    chest_crud.delete_chest_by_id(created_chest_id, db)
    # Assert: Correct number of chests in database after deletion
    chests = chest_crud.get_all_chests(db)
    assert len(chests) == number_of_chests_before
    # Assert: Correct chest was deleted from database
    deleted_chest = chest_crud.get_chest_by_id(created_chest_id, db)
    assert deleted_chest is None
    

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
