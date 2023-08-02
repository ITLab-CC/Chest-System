from sqlalchemy.orm import DeclarativeBase
from sqlalchemy.orm import mapped_column, Mapped, relationship, Session
from sqlalchemy import *


class Base(DeclarativeBase):
    pass


class Zuordnung(Base):
    __tablename__ = "zuordnung"

    KID: Mapped[int] = mapped_column(Integer, ForeignKey("kiste.KID"), primary_key=True)
    GID: Mapped[int] = mapped_column(
        Integer, ForeignKey("gegenstand.GID"), primary_key=True
    )
    Anzahl: Mapped[int] = mapped_column(Integer)

    def __repr__(self):
        return f"Zuordnung({self.KID}, {self.GID})"


class Kiste(Base):
    __tablename__ = "kiste"

    KID: Mapped[str] = mapped_column(Integer, primary_key=True, autoincrement=True)
    Name: Mapped[str] = mapped_column(String)
    Zuordnungen_Gegenstaende = relationship(
        "Gegenstand", secondary="zuordnung", back_populates="Zuordnungen_Kisten"
    )


class Gegenstand(Base):
    __tablename__ = "gegenstand"

    GID: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    Name: Mapped[int] = mapped_column(String)
    Zuordnungen_Kisten = relationship(
        "Kiste", secondary="zuordnung", back_populates="Zuordnungen_Gegenstaende"
    )

    def __repr__(self):
        return f"Gegenstand({self.GID}, {self.Name})"
