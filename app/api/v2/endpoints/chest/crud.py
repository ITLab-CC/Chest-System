import logging

from sqlalchemy.orm import Session

from app.database.models import Kiste, ItemKiste, Item
from app.api.v2.endpoints.chest.schemas import ChestCreateSchema, ChestItemQuantityCreateSchema

def create_chest(schema: ChestCreateSchema, db: Session):
    entity = Kiste(**schema.dict())
    db.add(entity)
    db.commit()
    logging.debug('Chest {} created'.format(entity.name))
    return entity

def get_chest_by_id(chest_id: int, db: Session):
    entity = db.query(Kiste).filter(Kiste.id == chest_id).first()
    return entity

def get_chest_by_name(chest_name: str, db: Session):
    entity = db.query(Kiste).filter(Kiste.name == chest_name).first()
    return entity

def get_all_chests(db: Session):
    return db.query(Kiste).order_by(Kiste.name).all()

def update_chest(chest: Kiste, changed_chest: ChestCreateSchema, db: Session):
    for key, value in changed_chest.dict().items():
        setattr(chest, key, value)

    db.commit()
    db.refresh(chest)
    logging.debug('Chest {} updated'.format(chest.name))
    return chest

def delete_chest_by_id(chest_id: int, db: Session):
    entity = get_chest_by_id(chest_id, db)
    if entity:
        db.delete(entity)
        db.commit()
        logging.debug('Chest {} deleted'.format(entity.name))

def get_specific_item_in_chest(chest_id: int, item_id: int, db: Session):
    item = db.query(ItemKiste).filter(ItemKiste.kiste_id == chest_id, ItemKiste.item_id == item_id).first()
    return item

def get_joined_items_by_chest_id(chest_id: int, db: Session):
    items = db.query(ItemKiste).join(Item).filter(ItemKiste.kiste_id == chest_id).all()
    for item in items:
        item.item_name = item.item.name
    return items

def add_item_to_chest(chest_id: int, item_id: int, quantity: int, db: Session):
    item = get_specific_item_in_chest(chest_id, item_id, db)
    if item:
        item.anzahl += quantity
        db.commit()
        logging.debug('Item {} added to chest {}'.format(item_id, chest_id))
        if item.anzahl == 0:
            logging.debug('Item empty after adding to chest, deleting')
            delete_item_from_chest(chest_id, item_id, db)
        return item
    else:
        item = ItemKiste(kiste_id=chest_id, item_id=item_id, anzahl=quantity)
        db.add(item)
        db.commit()
        logging.debug('Item {} added to chest {}'.format(item_id, chest_id))
        return item
    
def delete_item_from_chest(chest_id: int, item_id: int, db: Session):
    item = get_specific_item_in_chest(chest_id, item_id, db)
    if item:
        db.delete(item)
        db.commit()
        logging.debug('Item {} deleted from chest {}'.format(item_id, chest_id))
        return item
    else:
        logging.error('Item {} not found in chest {}'.format(item_id, chest_id))
        return None
    
def update_item_in_chest(chest_id: int, item_id: int, quantity: int, db: Session):
    item = get_specific_item_in_chest(chest_id, item_id, db)
    if item:
        item.anzahl = quantity
        db.commit()
        logging.debug('Item {} in chest {} updated'.format(item_id, chest_id))
        if item.anzahl == 0:
            logging.debug('Item empty after updating in chest, deleting')
            delete_item_from_chest(chest_id, item_id, db)
        return item
    else:
        logging.error('Item {} not found in chest {}'.format(item_id, chest_id))
        return None
