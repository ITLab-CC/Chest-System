from fastapi import APIRouter
import logging
router = APIRouter()

from fastapi import  HTTPException
from sqlalchemy import create_engine
from sqlalchemy import *
from sqlalchemy.orm import Session
from app.database.models import Base, ItemKiste, Kiste, Item
import os
# Get DB Connection from env
POSTGRES_USER = "root"
POSTGRES_PASSWORD = "root"
POSTGRES_HOST = "127.0.0.1"
POSTGRES_DB = "test_db"
# ENV
POSTGRES_USER = os.environ.get("DATABASE_USERNAME") or POSTGRES_USER
POSTGRES_PASSWORD = os.environ.get("DATABASE_PASSWORD") or POSTGRES_PASSWORD
POSTGRES_HOST = os.environ.get("DATABASE_HOST") or POSTGRES_HOST
POSTGRES_DB = os.environ.get("DATABASE_NAME") or POSTGRES_DB

DEV = os.environ.get("DEV") or False

connectionString = (
    f"postgresql+psycopg2://{POSTGRES_USER}:{POSTGRES_PASSWORD}@{POSTGRES_HOST}/{POSTGRES_DB}"
)

logging.info("V1: Connecting to DB: " + connectionString)

engine = create_engine(
    connectionString,
    echo=False,
    connect_args={"options": "-csearch_path=public"},
)


# def db_prep():
#     with Session(engine) as session:
#         # Check if DB is empty
#         if session.query(Kiste).first() is not None:
#             return
#         # create parent, append a child via association
#         p = Kiste(name="Kiste1", id=1)
#         a = ItemKiste(anzahl=5)
#         a.item = Item(name="Item1", id=1)
#         p.items.append(a)
#         session.add(p)
#         session.commit()


# # Create all tables and fill them with data
# with engine.connect() as con:
#     print("Creating tables")
    
#     Base.metadata.create_all(engine)
#     # Fill tables with data
#     db_prep()






@router.get("/")
async def root():
    return {"message": "Hello World"}


# GetAllKisten
@router.get("/kisten")
async def getAllKisten():
    with Session(engine) as session:
        kisten = session.query(Kiste).all()
        return kisten


# GetKisteById
@router.get("/kisten/{id}")
async def getKisteById(id: int):
    with Session(engine) as session:
        kiste = session.query(Kiste).filter(Kiste.id == id).first()
        return kiste


# CreateKiste
@router.post("/kisten")
async def createKiste(name: str):
    with Session(engine) as session:
        kNeu = Kiste(name=name)
        session.add(kNeu)
        session.commit()
        return Kiste(name=name, id=kNeu.id)


# UpdateKiste
@router.put("/kisten/{id}")
async def updateKiste(id: int, name: str):
    with Session(engine) as session:
        kiste = session.query(Kiste).filter(Kiste.id == id).first()
        kiste.name = name
        session.commit()
        return Kiste(name=name, id=kiste.id)


# DeleteKiste
@router.delete("/kisten/{id}")
async def deleteKiste(id: int, force: bool = False):
    with Session(engine) as session:
        if force:
            kiste = session.query(Kiste).filter(Kiste.id == id).first()
            for item in kiste.items:
                session.delete(item)
        kiste = session.query(Kiste).filter(Kiste.id == id).first()
        if kiste is None:
            return {"success": "false", "error": "Kiste not found"}
        session.delete(kiste)
        try:
            session.commit()
            return {"success": "true"}
        except:
            # Status 409: Conflict
            raise HTTPException(status_code=409, detail="Kiste is not empty")


# GetAllItems
@router.get("/items")
async def getAllItems():
    with Session(engine) as session:
        items = session.query(Item).all()
        return items


# GetItemById
@router.get("/items/{id}")
async def getItemById(id: int):
    with Session(engine) as session:
        item = session.query(Item).filter(Item.id == id).first()
        return item


# CreateItem description: Optional[str] = None
@router.post("/items")
async def createItem(name: str, description: str = None):
    with Session(engine) as session:
        iNeu = Item(name=name, description=description)
        session.add(iNeu)
        session.commit()
        return Item(name=name, description=description, id=iNeu.id)


# UpdateItem
@router.put("/items/{id}")
async def updateItem(id: int, name: str, description: str):
    with Session(engine) as session:
        item = session.query(Item).filter(Item.id == id).first()
        item.name = name
        item.description = description
        session.commit()
        return Item(name=name, description=description, id=item.id)


# DeleteItem
@router.delete("/items/{id}")
async def deleteItem(id: int, force: bool = False):
    with Session(engine) as session:
        if force:
            # Delete ItemKiste
            itemKisten = session.query(ItemKiste).filter(ItemKiste.item_id == id).all()
            for itemKiste in itemKisten:
                session.delete(itemKiste)
        item = session.query(Item).filter(Item.id == id).first()
        if item is None:
            return {"success": "false", "error": "Item not found"}
        session.delete(item)
        try:
            session.commit()
            return {"success": "true"}
        # Catch IntegrityError
        except:
            # Status 409: Conflict
            raise HTTPException(status_code=409, detail="Item is not empty")


# GetAllItemsInKiste
@router.get("/kisten/{id}/items")
async def getAllItemsInKiste(id: int):
    with Session(engine) as session:
        # Add Anzahl to Item
        items = (
            session.query(Item).join(ItemKiste).filter(ItemKiste.kiste_id == id).all()
        )
        for item in items:
            item.anzahl = (
                session.query(ItemKiste)
                .filter(ItemKiste.kiste_id == id)
                .filter(ItemKiste.item_id == item.id)
                .first()
                .anzahl
            )
        return items


# GetAllKistenByItemId
@router.get("/items/{id}/kisten")
async def getAllKistenByItemId(id: int):
    with Session(engine) as session:
        kisten = (
            session.query(Kiste).join(ItemKiste).filter(ItemKiste.item_id == id).all()
        )
        # Add Anzahl to Kiste
        for kiste in kisten:
            kiste.anzahl = (
                session.query(ItemKiste)
                .filter(ItemKiste.kiste_id == kiste.id)
                .filter(ItemKiste.item_id == id)
                .first()
                .anzahl
            )
        return kisten


# AddItemToKiste
@router.post("/kisten/{id}/items")
async def addItemToKiste(id: int, item_id: int, anzahl: int):
    with Session(engine) as session:
        # Check if Item is already in Kiste
        itemKiste = (
            session.query(ItemKiste)
            .filter(ItemKiste.kiste_id == id)
            .filter(ItemKiste.item_id == item_id)
            .first()
        )
        if itemKiste:
            itemKiste.anzahl += anzahl
            if itemKiste.anzahl <= 0:
                session.delete(itemKiste)
                session.commit()
                return {"success": "true"}
            session.commit()
            return itemKiste
        # Create new ItemKiste
        itemKiste = ItemKiste(anzahl=anzahl)
        itemKiste.item_id = item_id
        itemKiste.kiste_id = id
        session.add(itemKiste)
        session.commit()
        return itemKiste


# RemoveItemFromKiste
@router.delete("/kisten/{id}/items/{item_id}/${anzahl}")
async def removeItemFromKiste(id: int, item_id: int, anzahl: int):
    with Session(engine) as session:
        itemKiste = (
            session.query(ItemKiste)
            .filter(ItemKiste.kiste_id == id)
            .filter(ItemKiste.item_id == item_id)
            .first()
        )
        if itemKiste is None:
            return {"success": "false", "error": "Item not found"}
        itemKiste.anzahl -= anzahl
        if itemKiste.anzahl <= 0:
            session.delete(itemKiste)
        session.commit()
        return {"success": "true"}

