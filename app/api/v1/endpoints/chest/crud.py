import logging
import uuid

from sqlalchemy.orm import Session

from app.database.models import Kiste
from app.api.v1.endpoints.chest.schemas import ChestCreateSchema

def create_chest(schema: ChestCreateSchema, db: Session):
    entity = Kiste(**schema.dict())
    db.add(entity)
    db.commit()
    logging.debug('Chest {} created'.format(entity.name))
    return entity

def get_chest_by_id(chest_id: uuid.UUID, db: Session):
    entity = db.query(Kiste).filter(Kiste.id == chest_id).first()
    return entity

def get_chest_by_name(chest_name: str, db: Session):
    entity = db.query(Kiste).filter(Kiste.name == chest_name).first()
    return entity

def get_all_chests(db: Session):
    return db.query(Kiste).all()

def update_chest(chest: Kiste, changed_chest: ChestCreateSchema, db: Session):
    for key, value in changed_chest.dict().items():
        setattr(chest, key, value)

    db.commit()
    db.refresh(chest)
    logging.debug('Chest {} updated'.format(chest.name))
    return chest

def delete_chest_by_id(chest_id: uuid.UUID, db: Session):
    entity = get_chest_by_id(chest_id, db)
    if entity:
        db.delete(entity)
        db.commit()
        logging.debug('Chest {} deleted'.format(entity.name))
        
        