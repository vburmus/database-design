from neo4j import GraphDatabase
from faker import Faker

fake = Faker("pl_PL")


class Neo4jGenerator:
    def __init__(self, uri, user, pwd):
        self.__uri = uri
        self.__user = user
        self.__password = pwd
        self.__driver = None
        try:
            self.__driver = GraphDatabase.driver(
                self.__uri, auth=(self.__user, self.__password)
            )
        except Exception as e:
            print("Connection error", e)

    def close(self):
        if self.__driver is not None:
            self.__driver.close()

    def query(self, query, parameters=None, db=None):
        assert self.__driver is not None, "Driver not initialized!"
        session = None
        response = None
        try:
            session = (
                self.__driver.session(database=db)
                if db is not None
                else self.__driver.session()
            )
            response = list(session.run(query, parameters))
        except Exception as e:
            print("Error in query:", e)
        finally:
            if session is not None:
                session.close()
        return response

    def create_doctor(conn):
        first_name = fake.first_name()
        last_name = fake.last_name()
        pesel = fake.ssn()
        pzw_number = fake.bothify(text="#######")
        query = """
        CREATE (:Doctor {first_name: $first_name, last_name: $last_name, pesel: $pesel, pzw_number: $pzw_number})
        """
        conn.query(
            query,
            parameters={
                "first_name": first_name,
                "last_name": last_name,
                "pesel": pesel,
                "pzw_number": pzw_number,
            },
        )
