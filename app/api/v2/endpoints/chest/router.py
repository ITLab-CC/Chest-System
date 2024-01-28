import logging

from typing import List, TypeVar

from fastapi import APIRouter, Depends, Request, Response, status, HTTPException
from fastapi.responses import RedirectResponse
from sqlalchemy.orm import Session

import app.api.v2.endpoints.chest.crud as chest_crud
import app.api.v2.endpoints.item.crud as item_crud
from app.api.v2.endpoints.chest.schemas import ChestSchema, ChestCreateSchema,  ChestItemQuantityCreateSchema, ChestItemJoinedSchema
from app.database.connection import SessionLocal

router = APIRouter()


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.get('', response_model=List[ChestSchema], tags=['chest'])
def get_all_chests(db: Session = Depends(get_db)):
    return chest_crud.get_all_chests(db)


@router.post('', response_model=ChestSchema, status_code=status.HTTP_201_CREATED, tags=['chest'])
def create_chest(chest: ChestCreateSchema,
                 request: Request,
                 db: Session = Depends(get_db),
                 ):
    chest_found = chest_crud.get_chest_by_name(chest.name, db)
    if chest_found:
        logging.warning('Chest {} already exists'.format(chest.name))
        url = request.url_for('get_chest', chest_id=chest_found.id)
        return RedirectResponse(url=url, status_code=status.HTTP_303_SEE_OTHER)

    new_chest = chest_crud.create_chest(chest, db)
    logging.info('Chest {} created'.format(chest.name))
    return new_chest


@router.put('/{chest_id}', response_model=ChestSchema, tags=['chest'])
def update_chest(
        chest_id: int,
        changed_chest: ChestCreateSchema,
        request: Request,
        response: Response,
        db: Session = Depends(get_db),
):
    chest_found = chest_crud.get_chest_by_id(chest_id, db)
    updated_chest = None

    if chest_found:
        chest_name_found = chest_crud.get_chest_by_name(changed_chest.name, db)
        if chest_name_found and chest_name_found.id != chest_found.id:
            logging.warning('Update: Chest {} already exists'.format(changed_chest.name))
            url = request.url_for('get_chest', chest_id=chest_name_found.id)
            return RedirectResponse(url=url, status_code=status.HTTP_303_SEE_OTHER)
        else:
            updated_chest = chest_crud.update_chest(chest_found, changed_chest, db)
            logging.info('Chest {} updated'.format(chest_id))
    else:
        logging.warning('Update: Chest {} not found'.format(chest_id))
        raise HTTPException(status_code=404)

    return updated_chest


@router.get('/{chest_id}', response_model=ChestSchema, tags=['chest'])
def get_chest(chest_id: int,
              db: Session = Depends(get_db),
              ):
    chest = chest_crud.get_chest_by_id(chest_id, db)

    if not chest:
        logging.warning('Get: Chest {} not found'.format(chest_id))
        raise HTTPException(status_code=404)
    return chest


@router.delete('/{chest_id}', response_model=None, tags=['chest'], status_code=status.HTTP_204_NO_CONTENT)
def delete_chest(chest_id: int, db: Session = Depends(get_db)):
    chest = chest_crud.get_chest_by_id(chest_id, db)

    if not chest:
        logging.error('Delete: Chest {} not found'.format(chest_id))
        raise HTTPException(status_code=404)
    
    # Check if chest is empty
    items = chest_crud.get_joined_items_by_chest_id(chest_id, db)
    if items:
        logging.error('Delete: Chest {} not empty'.format(chest_id))
        raise HTTPException(status_code=409)

    chest_crud.delete_chest_by_id(chest_id, db)
    logging.info('Chest {} deleted'.format(chest.name))
    return Response(status_code=status.HTTP_204_NO_CONTENT)



@router.get('/{chest_id}/items', 
            response_model=ChestItemJoinedSchema,
            tags=['chest-items'])
def get_chest_items(chest_id: int, db: Session = Depends(get_db)):
    chest = chest_crud.get_chest_by_id(chest_id, db)

    if not chest:
        logging.error('Get: Chest {} not found'.format(chest_id))
        raise HTTPException(status_code=404)

    kistenItems = chest_crud.get_joined_items_by_chest_id(chest_id, db)
    logging.info('Get: Items in chest {}: {}'.format(chest_id, kistenItems))
    chest.items = kistenItems
    return chest

@router.post('/{chest_id}/items', response_model=ChestItemQuantityCreateSchema,
             status_code=status.HTTP_201_CREATED, tags=['chest-items'])
def add_item_to_chest(chest_id: int, item: ChestItemQuantityCreateSchema, db: Session = Depends(get_db)):
    chest = chest_crud.get_chest_by_id(chest_id, db)

    if not chest:
        logging.error('Post: Chest {} not found'.format(chest_id))
        raise HTTPException(status_code=404)

    
    item_entity = item_crud.get_item_by_id(item.item_id, db)
    if not item_entity:
        logging.error('Post: Item {} not found'.format(item.item_id))
        raise HTTPException(status_code=404)
    
    updated_quantity = chest_crud.add_item_to_chest(chest_id, item.item_id, item.anzahl, db)
    logging.info('Item {} added to chest {}'.format(item.item_id, chest_id))
    return updated_quantity

@router.delete('/{chest_id}/items/{item_id}', response_model=None, tags=['chest-items'])
def delete_item_from_chest(chest_id: int, item_id: int, db: Session = Depends(get_db)):
    chest = chest_crud.get_chest_by_id(chest_id, db)

    if not chest:
        logging.error('Delete: Chest {} not found'.format(chest_id))
        raise HTTPException(status_code=404)

    item = chest_crud.get_specific_item_in_chest(chest_id, item_id, db)
    if not item:
        logging.error('Delete: Item {} not found'.format(item_id))
        raise HTTPException(status_code=404)

    chest_crud.delete_item_from_chest(chest_id, item_id, db)
    logging.info('Item {} deleted from chest {}'.format(item_id, chest_id))
    return Response(status_code=status.HTTP_204_NO_CONTENT)

@router.put('/{chest_id}/items', response_model=ChestItemQuantityCreateSchema, tags=['chest-items'])
def update_item_quantity_in_chest(chest_id: int, updated_quantity: ChestItemQuantityCreateSchema, db: Session = Depends(get_db)):
    chest = chest_crud.get_chest_by_id(chest_id, db)

    if not chest:
        logging.error('Put: Chest {} not found'.format(chest_id))
        raise HTTPException(status_code=404)

    item = chest_crud.get_specific_item_in_chest(chest_id, updated_quantity.item_id, db)
    if not item:
        logging.error('Put: Item {} not found'.format(updated_quantity.item_id))
        raise HTTPException(status_code=404)

    chest_crud.update_item_in_chest(chest_id, updated_quantity.item_id, updated_quantity.anzahl, db)
    logging.info('Item {} in chest {} updated'.format(updated_quantity.item_id, chest_id))
    return updated_quantity