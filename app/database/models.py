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
    item_id: Mapped[int] = mapped_column(
        ForeignKey("item.id"), primary_key=True
    )
    anzahl: Mapped[int] = mapped_column(Integer, default=1, nullable=False)
    item: Mapped["Item"] = relationship(back_populates="kistes")
    kiste: Mapped["Kiste"] = relationship(back_populates="items")


class Kiste(Base):
    __tablename__ = "kiste"
    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column()
    location: Mapped[str] = mapped_column(default="unknown")
    items: Mapped[List["ItemKiste"]] = relationship(back_populates="kiste")


class Item(Base):
    __tablename__ = "item"
    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column()
    description: Mapped[Optional[str]] = mapped_column()
    kistes: Mapped[List["ItemKiste"]] = relationship(back_populates="item")
    
class AuditLog(Base):
    __tablename__ = "auditlog"
    id: Mapped[int] = mapped_column(primary_key=True)
    timestamp: Mapped[str] = mapped_column()
    request: Mapped[str] = mapped_column()
    response: Mapped[str] = mapped_column()
    user: Mapped[str] = mapped_column()
    ip: Mapped[str] = mapped_column()
    status_code: Mapped[int] = mapped_column()