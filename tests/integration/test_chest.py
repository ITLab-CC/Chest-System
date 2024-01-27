import pytest
import uuid

import app.api.v1.endpoints.chest.crud as chest_crud
from app.api.v1.endpoints.chest.schemas import ChestCreateSchema
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
