from fastapi import FastAPI, Query, HTTPException, Path
from pydantic import BaseModel
from typing import Optional
import json
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy import create_engine
from sqlalchemy import *
from sqlalchemy.orm import mapped_column, Mapped, relationship, Session
from models.models import Base, ItemKiste, Kiste, Item
import uvicorn

engine = create_engine(
    "postgresql+psycopg2://root:root@127.0.0.1/test_db",
    echo=False,
    connect_args={"options": "-csearch_path=public"},
)
app = FastAPI()

origins = [
    "http://localhost:3000",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Create all tables and fill them with data
with engine.connect() as con:
    print("Dropping all tables and creating new ones...")
    # Drop all tables
    Base.metadata.drop_all(engine)
    Base.metadata.create_all(engine)


def db_prep():
    with Session(engine) as session:
        # create parent, append a child via association
        p = Kiste(name="Kiste1")
        a = ItemKiste(anzahl=5)
        a.item = Item(name="Item1")
        p.items.append(a)
        session.add(p)
        session.commit()


db_prep()


apiPrefix = "/api/v1"


@app.get("/")
async def root():
    return {"message": "Hello World"}


# GetAllKisten
@app.get(apiPrefix + "/kisten")
async def getAllKisten():
    with Session(engine) as session:
        kisten = session.query(Kiste).all()
        return kisten


# GetKisteById
@app.get(apiPrefix + "/kisten/{id}")
async def getKisteById(id: int):
    with Session(engine) as session:
        kiste = session.query(Kiste).filter(Kiste.id == id).first()
        return kiste


# CreateKiste
@app.post(apiPrefix + "/kisten")
async def createKiste(name: str):
    with Session(engine) as session:
        kNeu = Kiste(name=name)
        session.add(kNeu)
        session.commit()
        return Kiste(name=name, id=kNeu.id)


# UpdateKiste
@app.put(apiPrefix + "/kisten/{id}")
async def updateKiste(id: int, name: str):
    with Session(engine) as session:
        kiste = session.query(Kiste).filter(Kiste.id == id).first()
        kiste.name = name
        session.commit()
        return Kiste(name=name, id=kiste.id)


# DeleteKiste
@app.delete(apiPrefix + "/kisten/{id}")
async def deleteKiste(id: int, force: bool = False):
    with Session(engine) as session:
        if force:
            kiste = session.query(Kiste).filter(Kiste.id == id).first()
            for item in kiste.items:
                session.delete(item)
        kiste = session.query(Kiste).filter(Kiste.id == id).first()
        session.delete(kiste)
        session.commit()
        return {"success": "true"}


# GetAllItems
@app.get(apiPrefix + "/items")
async def getAllItems():
    with Session(engine) as session:
        items = session.query(Item).all()
        return items


# GetItemById
@app.get(apiPrefix + "/items/{id}")
async def getItemById(id: int):
    with Session(engine) as session:
        item = session.query(Item).filter(Item.id == id).first()
        return item


# CreateItem description: Optional[str] = None
@app.post(apiPrefix + "/items")
async def createItem(name: str, description: str = None):
    with Session(engine) as session:
        iNeu = Item(name=name, description=description)
        session.add(iNeu)
        session.commit()
        return Item(name=name, description=description, id=iNeu.id)


# UpdateItem
@app.put(apiPrefix + "/items/{id}")
async def updateItem(id: int, name: str, description: str):
    with Session(engine) as session:
        item = session.query(Item).filter(Item.id == id).first()
        item.name = name
        item.description = description
        session.commit()
        return Item(name=name, description=description, id=item.id)


# DeleteItem
@app.delete(apiPrefix + "/items/{id}")
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
            return {
                "success": "false",
                "message": "Item is in use. Use force to delete it anyway",
            }


# GetAllItemsInKiste
@app.get(apiPrefix + "/kisten/{id}/items")
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
@app.get(apiPrefix + "/items/{id}/kisten")
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
@app.post(apiPrefix + "/kisten/{id}/items")
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
@app.delete(apiPrefix + "/kisten/{id}/items/{item_id}/${anzahl}")
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


if __name__ == "__main__":
    uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)
