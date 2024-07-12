import logging
from fastapi import APIRouter, Depends, Request, Response, HTTPException, status
from typing import List
from fastapi.responses import RedirectResponse
import app.api.v2.endpoints.cupboard.crud as cupboard_crud
import app.api.v2.endpoints.chest.crud as chest_crud
from app.api.v2.endpoints.cupboard.schemas import CupboardBaseModel, CupboardSchema, CupboardCreateSchema, CupboardChestJoinedSchema, CupboardChestQuantityCreateSchema, CupboardChestQuantitySchema
from app.api.v2.endpoints.chest.schemas import ChestSchema
from app.database.connection import SessionLocal
from sqlalchemy.orm import Session
from app.database.models import Cupboard

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.get('', response_model=List[CupboardSchema], tags=["cupboard"])
def get_all_cupboards(db: Session = Depends(get_db)):
    return cupboard_crud.get_all_cupboards(db)

@router.put('/{cupboard_id}', response_model=CupboardSchema, tags=['cupboard'])
def update_cupbaord(
        cupboard_id: int,
        changed_cupboard: CupboardCreateSchema,
        request: Request,
        response: Response,
        db: Session = Depends(get_db),
):
    cupboard_found = cupboard_crud.get_cupboard_by_id(cupboard_id, db)
    updated_cupboard = None
    logging.info("Test")

    if cupboard_found:
        cupboard_name_found = cupboard_crud.get_cupboard_by_name(changed_cupboard.cupboard_name, db)
        if cupboard_name_found and cupboard_name_found.id != cupboard_name_found.id:
            logging.warning('Update: Item {} already exists'.format(changed_cupboard.cupboard_name))
            url = request.url_for('get_item', cupboard_id=cupboard_name_found.id)
            return RedirectResponse(url=url, status_code=status.HTTP_303_SEE_OTHER)
        else:
            updated_cupboard = cupboard_crud.update_cupboard(cupboard_found, changed_cupboard, db)
            logging.info('Item {} updated'.format(cupboard_id))
    else:
        logging.warning('Update: Item {} not found'.format(cupboard_id))
        raise HTTPException(status_code=404)

    return updated_cupboard

@router.get('/{cupboard_id}', response_model=CupboardSchema, tags=['cupboard'])
def get_item(cupboard_id: int,
              db: Session = Depends(get_db),
              ):
    cupboard = cupboard_crud.get_cupboard_by_id(cupboard_id, db)

    if not cupboard:
        logging.warning('Get: Item {} not found'.format(cupboard_id))
        raise HTTPException(status_code=404)
    return cupboard

@router.delete('/{cupboard_id}', response_model=None, tags=['cupboard'], status_code=status.HTTP_204_NO_CONTENT)
def delete_chest(cupboard_id: int, db: Session = Depends(get_db)):
    cupboard = cupboard_crud.get_cupboard_by_id(cupboard_id, db)

    if not cupboard:
        logging.error('Delete: Cupboard {} not found'.format(cupboard_id))
        raise HTTPException(status_code=404)
    
    # # Check if cupboard is empty
    # items = chest_crud.get_joined_items_by_chest_id(chest_id, db)
    # if items:
    #     logging.error('Delete: Chest {} not empty'.format(chest_id))
        # raise HTTPException(status_code=409)

    cupboard_crud.delete_cupboard_by_id(cupboard_id, db)
    logging.info('Cupboard {} deleted'.format(cupboard.cupboard_name))
    return Response(status_code=status.HTTP_204_NO_CONTENT)

@router.post('', response_model=CupboardSchema, status_code=status.HTTP_201_CREATED, tags=['cupboard'])
def create_cupboard(cupboard: CupboardCreateSchema,
                 request: Request,
                 db: Session = Depends(get_db),
                 ):
    cupboard_found = cupboard_crud.get_cupboard_by_name(cupboard.cupboard_name, db)
    if cupboard_found:
        logging.warning('Cupboard {} already exists'.format(cupboard.cupboard_name))
        url = request.url_for('get_cupboard', cupboard_id=cupboard_found.id)
        return RedirectResponse(url=url, status_code=status.HTTP_303_SEE_OTHER)

    new_cupboard = cupboard_crud.create_cupboard(cupboard, db)
    logging.info('Cupboard {} created'.format(cupboard.cupboard_name))
    return new_cupboard

@router.get('/{cupboard_id}/chests', 
            response_model=CupboardChestJoinedSchema,
            tags=['cupboard-chests'])
def get_cupboard_chests(cupboard_id: int, db: Session = Depends(get_db)):
    cupboard = cupboard_crud.get_cupboard_by_id(cupboard_id, db)

    if not cupboard:
        logging.error('Get: Cupboard {} not found'.format(cupboard_id))
        raise HTTPException(status_code=404)

    cupboardChests = cupboard_crud.get_joined_chests_by_cupboard_id(cupboard_id, db)
    logging.info('Get: Chests in cupboards {}: {}'.format(cupboard_id, cupboardChests))
    cupboard.kistes = cupboardChests
    return cupboard

@router.put('/{cupboard_id}/chests', response_model=ChestSchema,
             status_code=status.HTTP_201_CREATED, tags=['cupboard-chests'])
def add_chest_to_cupboard(cupboard_id: int, chest: CupboardChestQuantityCreateSchema, db: Session = Depends(get_db)):
    cupboard = cupboard_crud.get_cupboard_by_id(cupboard_id, db)

    if not cupboard:
        logging.error('Post: Cupboard {} not found'.format(cupboard_id))
        raise HTTPException(status_code=404)
    
    chest_entity = chest_crud.get_chest_by_id(chest.chest_id, db)
    if not chest_entity:
        logging.error('Post: Chest {} not found'.format(chest.chest_id))
        raise HTTPException(status_code=404)
    
    # chest_entity.cupboard_id = cupboard_id
    # db.commit()
    
    updated_chest = cupboard_crud.add_chest_to_cupboard(cupboard_id, chest.chest_id, db)
    if updated_chest:
        return updated_chest
    else:
        logging.error('Chest {} not updated correctly'.format(chest.chest_id))
        raise HTTPException(status_code=400)

@router.delete('/{cupboard_id}/chests/{chest_id}', response_model=None, tags=['cupboard-chests'])
def delete_chest_from_cupboard(cupboard_id: int, chest_id: int, db: Session = Depends(get_db)):
    cupboard = cupboard_crud.get_cupboard_by_id(cupboard_id, db)

    if not cupboard:
        logging.error('Delete: Cupboard {} not found'.format(cupboard_id))
        raise HTTPException(status_code=404)

    chest = chest_crud.get_specific_cupboard_in_chest(cupboard_id, chest_id, db)
    if not chest:
        logging.error('Delete: Chest {} not found'.format(chest_id))
        raise HTTPException(status_code=404)

    chest_crud.delete_cupboard_from_chest(cupboard_id, chest_id, db)
    logging.info('Cupboard {} deleted from chest {}'.format(cupboard_id, chest_id))
    return Response(status_code=status.HTTP_204_NO_CONTENT)