import logging

from sqlalchemy.orm import Session

from app.database.models import Item, ItemKiste, Kiste
from app.api.v2.endpoints.item.schemas import ItemCreateSchema

def create_item(schema: ItemCreateSchema, db: Session):
    entity = Item(**schema.dict())
    db.add(entity)
    db.commit()
    logging.debug('Item {} created'.format(entity.name))
    return entity

def get_item_by_id(item_id: int, db: Session):
    entity = db.query(Item).filter(Item.id == item_id).first()
    return entity

def get_item_by_name(item_name: str, db: Session):
    entity = db.query(Item).filter(Item.name == item_name).first()
    return entity

def get_all_items(db: Session):
    return db.query(Item).all()

def update_item(item: Item, changed_item: ItemCreateSchema, db: Session):
    for key, value in changed_item.dict().items():
        setattr(item, key, value)

    db.commit()
    db.refresh(item)
    logging.debug('Item {} updated'.format(item.name))
    return item

def delete_item_by_id(item_id: int, db: Session):
    entity = get_item_by_id(item_id, db)
    if entity:
        db.delete(entity)
        db.commit()
        logging.debug('Item {} deleted'.format(entity.name))
        
def get_joined_chests_by_item_id(item_id: int, db: Session):
    chests = db.query(ItemKiste).join(Kiste).filter(ItemKiste.item_id == item_id).all()
    return chests