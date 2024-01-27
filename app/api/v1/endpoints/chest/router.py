import logging

from typing import List, TypeVar

from fastapi import APIRouter, Depends, Request, Response, status, HTTPException
from fastapi.responses import RedirectResponse
from sqlalchemy.orm import Session

import app.api.v1.endpoints.chest.crud as chest_crud
import app.api.v1.endpoints.item.crud as item_crud
from app.api.v1.endpoints.chest.schemas import ChestSchema, ChestCreateSchema, ChestListItemSchema, JoinedChestItemSchema, ChestItemCreateSchema
from app.database.connection import SessionLocal

router = APIRouter()


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.get('', response_model=List[ChestListItemSchema], tags=['chest'])
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
        if chest_found.name == changed_chest.name:
            logging.debug('Chest {} found. Keeping name'.format(chest_id))
            chest_crud.update_chest(chest_found, changed_chest, db)
            return Response(status_code=status.HTTP_204_NO_CONTENT)
        else:
            chest_name_found = chest_crud.get_chest_by_name(changed_chest.name, db)
            if chest_name_found:
                logging.warning('Chest {} already exists'.format(changed_chest.name))
                url = request.url_for('get_chest', chest_id=chest_name_found.id)
                return RedirectResponse(url=url, status_code=status.HTTP_303_SEE_OTHER)
            else:
                logging.debug('Chest {} name changed'.format(chest_found.name))
                updated_chest = chest_crud.create_chest(changed_chest, db)
                response.status_code = status.HTTP_201_CREATED
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


@router.delete('/{chest_id}', response_model=None, tags=['chest'])
def delete_chest(chest_id: int, db: Session = Depends(get_db)):
    chest = chest_crud.get_chest_by_id(chest_id, db)

    if not chest:
        logging.error('Delete: Chest {} not found'.format(chest_id))
        raise HTTPException(status_code=404)

    chest_crud.delete_chest_by_id(chest_id, db)
    logging.info('Chest {} deleted'.format(chest.name))
    return Response(status_code=status.HTTP_204_NO_CONTENT)



@router.get('/{chest_id}/items', 
            # response_model=JoinedChestItemSchema, 
            tags=['chest'])
def get_chest_items(chest_id: int, db: Session = Depends(get_db)):
    chest = chest_crud.get_chest_by_id(chest_id, db)

    if not chest:
        logging.error('Get: Chest {} not found'.format(chest_id))
        raise HTTPException(status_code=404)

    items = chest_crud.get_joined_items_by_chest_id(chest_id, db)
    chest.items = items
    return chest

@router.post('/{chest_id}/items', response_model=ChestItemCreateSchema,
             status_code=status.HTTP_201_CREATED, tags=['chest'])
def add_item_to_chest(chest_id: int, item: ChestItemCreateSchema, db: Session = Depends(get_db)):
    chest = chest_crud.get_chest_by_id(chest_id, db)

    if not chest:
        logging.error('Post: Chest {} not found'.format(chest_id))
        raise HTTPException(status_code=404)

    
    item_entity = item_crud.get_item_by_id(item.item_id, db)
    if not item_entity:
        logging.error('Post: Item {} not found'.format(item.item_id))
        raise HTTPException(status_code=404)
    
    chest_crud.add_item_to_chest(chest_id, item.item_id, item.anzahl, db)
    logging.info('Item {} added to chest {}'.format(item.item_id, chest_id))
    return item
