from sqlalchemy import *
from sqlalchemy.orm import mapped_column, Mapped, relationship, Session
from models.models import Base, Eigentuemer, Person, Berechtigte, Schliessfach

engine = create_engine(
    "postgresql+psycopg2://postgres:postgres@10.2.0.110/postgres",
    echo=False,
    connect_args={"options": "-csearch_path=schliessfach"},
)
import os

clear_console = lambda: os.system("cls" if os.name in ("nt", "dos") else "clear")


# Insert data into the database
def db_fill():
    with Session(engine) as session:
        eig1 = Eigentuemer("Eigentuemer1", "DE")
        eig2 = Eigentuemer("Eigentuemer2", "DE")
        session.add_all([eig1, eig2])
        sf1 = Schliessfach("2021-01-01")
        sf2 = Schliessfach("2021-01-01")
        sf3 = Schliessfach("2021-01-01")
        sf4 = Schliessfach("2021-01-01")
        sf1.Schliessfach_Eigentuemer = eig1
        sf2.Schliessfach_Eigentuemer = eig1
        sf3.Schliessfach_Eigentuemer = eig2
        sf4.Schliessfach_Eigentuemer = eig2
        session.add_all([sf1, sf2, sf3, sf4])
        p1 = Person("VName1", "NName1")
        p2 = Person("VName2", "NName2")
        p3 = Person("VName3", "NName3")
        session.add_all([p1, p2, p3])
        session.commit()
        # Add Berechtigte with the created objects Pids
        sf1Berecht = [Berechtigte(sf1.SID, p1.PID), Berechtigte(sf1.SID, p2.PID)]
        sf2Berecht = Berechtigte(sf2.SID, p1.PID)
        # Sf3 has no Berechtigte
        session.add_all(sf1Berecht)
        session.add(sf2Berecht)
        session.commit()


# Create all tables and fill them with data
with engine.connect() as con:
    print("Dropping all tables and creating new ones...")
    # Drop all tables
    Base.metadata.drop_all(engine)
    Base.metadata.create_all(engine)
    db_fill()


def menu():
    clear_console()
    with Session(engine) as session:
        while True:
            print("1: Ausgabe aller Eigentümer")
            print(
                "2: Ausgabe aller Schließfächer eines Eigentümers (Eigentümer wird eingegeben)"
            )
            print("3: Ausgabe aller Personen")
            print(
                "4: Ausgabe aller Schließfächer eines Berechtigten (PersonenID wird eingegeben)"
            )
            print("5: Exit")
            choice = input("Enter your choice: ")
            print("")
            # clear_console()

            if choice == "1":
                result = session.query(Eigentuemer).all()
                for row in result:
                    print(row)
            elif choice == "2":
                eigentuemer = input("Enter Eigentuemer: ")
                result = (
                    session.query(Schliessfach)
                    .filter(Schliessfach.Besitzer_Unternehmensname == eigentuemer)
                    .all()
                )
                if len(result) == 0:
                    print("No Schliessfach for this Eigentuemer")
                for row in result:
                    print(row)
            elif choice == "3":
                print_all_persons(session)
            elif choice == "4":
                print_all_persons(session)
                print("")
                pid = input("Enter PID: ")
                result = (
                    session.query(Schliessfach)
                    .filter(Schliessfach.Berechtigte_Personen.any(PID=pid))
                    .all()
                )
                if len(result) == 0:
                    print("No Schliessfach for this PID")
                for row in result:
                    print(row)
            elif choice == "5":
                break
            else:
                print("Invalid input")
            print("")


def print_all_persons(session):
    result = session.query(Person).all()
    for row in result:
        print(row)


if __name__ == "__main__":
    menu()
