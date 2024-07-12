from typing import Optional, List

from sqlalchemy import ForeignKey
from sqlalchemy import Integer
from sqlalchemy.orm import Mapped
from sqlalchemy.orm import mapped_column
from sqlalchemy.orm import DeclarativeBase
from sqlalchemy.orm import relationship


from sqlalchemy.ext.declarative import declarative_base


Base = declarative_base()
metadata = Base.metadata


class ItemKiste(Base):
    __tablename__ = "itemkiste"
    kiste_id: Mapped[int] = mapped_column(ForeignKey("kiste.id"), primary_key=True)
    item_id: Mapped[int] = mapped_column(ForeignKey("item.id"), primary_key=True)
    anzahl: Mapped[int] = mapped_column(Integer, default=1, nullable=False)
    item: Mapped["Item"] = relationship(back_populates="kistes")
    kiste: Mapped["Kiste"] = relationship(back_populates="items")


class Kiste(Base):
    __tablename__ = "kiste"
    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column()
    items: Mapped[List["ItemKiste"]] = relationship(back_populates="kiste")
    cupboard: Mapped["Cupboard"] = relationship(back_populates="kistes")
    cupboard_id: Mapped[int] = mapped_column(ForeignKey("cupboard.id"), nullable=True)


class Item(Base):
    __tablename__ = "item"
    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column()
    description: Mapped[Optional[str]] = mapped_column()
    kistes: Mapped[List["ItemKiste"]] = relationship(back_populates="item")

class Cupboard(Base):
    __tablename__ = "cupboard"
    id: Mapped[int] = mapped_column(primary_key=True)
    cupboard_name: Mapped[str] = mapped_column()
    location: Mapped[str] = mapped_column(default="unknown")
    kistes: Mapped[List["Kiste"]] = relationship(back_populates="cupboard") 