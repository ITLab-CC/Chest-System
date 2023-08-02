from fastapi import FastAPI, Query, HTTPException, Path
from pydantic import BaseModel
from typing import Optional
import json
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy import create_engine

from sqlalchemy.orm import mapped_column, Mapped, relationship, Session
from models.models import Base, Kiste, Gegenstand, Zuordnung

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


def db_fill():
    with Session(engine) as session:
        kiste1 = Kiste(Name="Kiste1")
        gegenstand1 = Gegenstand(Name="Gegenstand1")
        zuordnung1 = Zuordnung(KID=1, GID=1, Anzahl=1)
        session.add_all([kiste1, gegenstand1])
        session.commit()
        session.add(zuordnung1)
        session.commit()


# Create all tables and fill them with data
with engine.connect() as con:
    print("Dropping all tables and creating new ones...")
    # Drop all tables
    Base.metadata.drop_all(engine)
    Base.metadata.create_all(engine)
    db_fill()


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/kisten")
async def get_kisten():
    with Session(engine) as session:
        kisten = session.query(Kiste).all()
        return kisten


@app.get("/kisten/add/{kiste_name}")
async def add_kiste(kiste_name: str):
    with Session(engine) as session:
        kiste = Kiste(Name=kiste_name)
        session.add(kiste)
        session.commit()
        return kiste


@app.get("/kisten/delete/{kiste_id}")
async def delete_kiste(kiste_id: int):
    with Session(engine) as session:
        kiste = session.query(Kiste).get(kiste_id)
        session.delete(kiste)
        session.commit()
        return kiste


@app.get("/gegenstaende")
async def get_gegenstaende():
    with Session(engine) as session:
        gegenstaende = session.query(Gegenstand).all()
        return gegenstaende


@app.get("/gegenstaende/add/{gegenstand_name}")
async def add_gegenstand(gegenstand_name: str):
    with Session(engine) as session:
        gegenstand = Gegenstand(Name=gegenstand_name)
        session.add(gegenstand)
        session.commit()
        return gegenstand


@app.get("/gegenstaende/delete/{gegenstand_id}")
async def delete_gegenstand(gegenstand_id: int):
    with Session(engine) as session:
        gegenstand = session.query(Gegenstand).get(gegenstand_id)
        session.delete(gegenstand)
        session.commit()
        return gegenstand


@app.get("/zuordnungen")
async def get_zuordnungen():
    with Session(engine) as session:
        zuordnungen = session.query(Zuordnung).all()
        return zuordnungen


@app.get("/zuordnungen/add/{kiste_id}/{gegenstand_id}/{anzahl}")
async def add_zuordnung(kiste_id: int, gegenstand_id: int, anzahl: int):
    with Session(engine) as session:
        zuordnung = Zuordnung(KID=kiste_id, GID=gegenstand_id, Anzahl=anzahl)
        session.add(zuordnung)
        session.commit()
        return zuordnung


@app.get("/zuordnungen/delete/{kiste_id}/{gegenstand_id}")
async def delete_zuordnung_by_kiste_gegenstand(kiste_id: int, gegenstand_id: int):
    with Session(engine) as session:
        zuordnung = (
            session.query(Zuordnung)
            .filter(Zuordnung.KID == kiste_id, Zuordnung.GID == gegenstand_id)
            .first()
        )
        session.delete(zuordnung)
        session.commit()
        return zuordnung
