import logging

from typing import List

from fastapi import APIRouter, Depends, Request, Response, status, HTTPException
from fastapi.responses import RedirectResponse
from sqlalchemy.orm import Session

import app.api.v1.endpoints.item.crud as item_crud
from app.api.v1.endpoints.item.schemas import ItemSchema, ItemCreateSchema, ItemListItemSchema
from app.database.connection import SessionLocal

router = APIRouter()


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.get('', response_model=List[ItemListItemSchema], tags=['item'])
def get_all_items(db: Session = Depends(get_db)):
    return item_crud.get_all_items(db)


@router.post('', response_model=ItemSchema, status_code=status.HTTP_201_CREATED, tags=['item'])
def create_item(item: ItemCreateSchema,
                 request: Request,
                 db: Session = Depends(get_db),
                 ):
    item_found = item_crud.get_item_by_name(item.name, db)
    if item_found:
        logging.warning('Item {} already exists'.format(item.name))
        url = request.url_for('get_item', item_id=item_found.id)
        return RedirectResponse(url=url, status_code=status.HTTP_303_SEE_OTHER)

    new_item = item_crud.create_item(item, db)
    logging.info('Item {} created'.format(item.name))
    return new_item


@router.put('/{item_id}', response_model=ItemSchema, tags=['item'])
def update_item(
        item_id: int,
        changed_item: ItemCreateSchema,
        request: Request,
        response: Response,
        db: Session = Depends(get_db),
):
    item_found = item_crud.get_item_by_id(item_id, db)
    updated_item = None

    if item_found:
        if item_found.name == changed_item.name:
            logging.debug('Item {} found. Keeping name'.format(item_id))
            item_crud.update_item(item_found, changed_item, db)
            return Response(status_code=status.HTTP_204_NO_CONTENT)
        else:
            item_name_found = item_crud.get_item_by_name(changed_item.name, db)
            if item_name_found:
                logging.warning('Item {} already exists'.format(changed_item.name))
                url = request.url_for('get_item', item_id=item_name_found.id)
                return RedirectResponse(url=url, status_code=status.HTTP_303_SEE_OTHER)
            else:
                logging.debug('Item {} name changed'.format(item_found.name))
                updated_item = item_crud.create_item(changed_item, db)
                response.status_code = status.HTTP_201_CREATED
    else:
        logging.warning('Update: Item {} not found'.format(item_id))
        raise HTTPException(status_code=404)

    return updated_item


@router.get('/{item_id}', response_model=ItemSchema, tags=['item'])
def get_item(item_id: int,
              db: Session = Depends(get_db),
              ):
    item = item_crud.get_item_by_id(item_id, db)

    if not item:
        logging.warning('Get: Item {} not found'.format(item_id))
        raise HTTPException(status_code=404)
    return item


@router.delete('/{item_id}', response_model=None, tags=['item'])
def delete_item(item_id: int, db: Session = Depends(get_db)):
    item = item_crud.get_item_by_id(item_id, db)

    if not item:
        logging.error('Delete: Item {} not found'.format(item_id))
        raise HTTPException(status_code=404)

    item_crud.delete_item_by_id(item_id, db)
    logging.info('Item {} deleted'.format(item.name))
    return Response(status_code=status.HTTP_204_NO_CONTENT)
