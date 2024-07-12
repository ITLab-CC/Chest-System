import logging
from sqlalchemy.orm import Session
from app.database.models import ItemKiste, Kiste, Cupboard
import app.api.v2.endpoints.chest.crud as chest_crud
from app.api.v2.endpoints.cupboard.schemas import CupboardCreateSchema

def get_all_cupboards(db: Session):
    return db.query(Cupboard).all()

def get_cupboard_by_name(cupboard_name: str, db: Session):
    entity = db.query(Cupboard).filter(Cupboard.cupboard_name == cupboard_name).first()
    return entity

def get_cupboard_by_id(cupboard_id: int, db: Session):
    entity = db.query(Cupboard).filter(Cupboard.id == cupboard_id).first()
    return entity

def update_cupboard(cupboard: Cupboard, changed_cupboard: CupboardCreateSchema, db: Session):
    for key, value in changed_cupboard.dict().items():
        setattr(cupboard, key, value)
    db.commit()
    db.refresh(cupboard)
    logging.debug('Cupboard {} updated'.format(cupboard.cupboard_name))
    return cupboard

def delete_cupboard_by_id(cupboard_id: int, db: Session):
    entity = get_cupboard_by_id(cupboard_id, db)
    if entity:
        db.delete(entity)
        db.commit()
        logging.debug('Chest {} deleted'.format(entity.cupboard_name))

def create_cupboard(schema: CupboardCreateSchema, db: Session):
    entity = Cupboard(**schema.dict())
    db.add(entity)
    db.commit()
    logging.debug('Chest {} created'.format(entity.cupboard_name))
    return entity

def get_joined_chests_by_cupboard_id(cupboard_id: int, db: Session):
    chests = db.query(Kiste).join(Cupboard).filter(Cupboard.id == cupboard_id).all()
    for chest in chests:
        chest.chest_name = chest.name
        chest.chest_id = chest.id
    return chests

def get_specific_chest_in_cupboard(cupboard_id: int, chest_id: int, db: Session):
    item = db.query(Kiste).filter(Kiste.cupboard_id  == cupboard_id, Kiste.id == chest_id).first()
    return item

def add_chest_to_cupboard(cupboard_id: int, chest_id: int, db: Session):
    chest = chest_crud.get_chest_by_id(chest_id, db)
    if chest: # Positiv
        chest.cupboard_id=cupboard_id
        db.commit()
        logging.debug('Chest {} exists {}'.format(chest_id, cupboard_id))
        #print(chest)
        return chest
    else:
        logging.debug('Chest {} does not exsist in {}'.format(chest_id, cupboard_id))
        return None
