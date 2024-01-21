from neo4j import GraphDatabase
from faker import Faker
from tqdm import tqdm
import random

fake = Faker("pl_PL")

CATEGORIES = {
    "A": "Alimentary tract and metabolism",
    "B": "Blood and blood forming organs",
    "C": "Cardiovascular system",
    "D": "Dermatologicals",
    "G": "Genito-urinary system and sex hormones",
    "H": "Systemic hormonal preparations, excluding sex hormones and insulins",
    "J": "Antiinfectives for systemic use",
    "L": "Antineoplastic and immunomodulating agents",
    "M": "Musculo-skeletal system",
    "N": "Nervous system",
    "P": "Antiparasitic products, insecticides and repellents",
    "R": "Respiratory system",
    "S": "Sensory organs",
    "V": "Various",
}

SPECIALIZATIONS = [
    "Alergologia",
    "Anestezjologia i intensywna terapia",
    "Angiologia",
    "Audiologia i foniatria",
    "Balneologia i medycyna fizykalna",
    "Chirurgia dziecięca",
    "Chirurgia klatki piersiowej",
    "Chirurgia naczyniowa",
    "Chirurgia ogólna",
    "Chirurgia onkologiczna",
    "Chirurgia plastyczna",
    "Chirurgia szczękowo-twarzowa",
    "Choroby płuc",
    "Choroby płuc dzieci",
    "Choroby wewnętrzne",
    "Choroby zakaźne",
    "Dermatologia i wenerologia",
    "Diabetologia",
    "Diagnostyka laboratoryjna",
    "Endokrynologia",
    "Endokrynologia ginekologiczna i rozrodczość",
    "Endokrynologia i diabetologia dziecięca",
    "Epidemiologia",
    "Farmakologia kliniczna",
    "Gastroenterologia",
    "Gastroenterologia dziecięca",
    "Genetyka kliniczna",
    "Geriatria",
    "Ginekologia onkologiczna",
    "Hematologia",
    "Hipertensjologia",
    "Immunologia kliniczna",
    "Intensywna terapia",
    "Kardiochirurgia",
    "Kardiologia",
    "Kardiologia dziecięca",
    "Medycyna lotnicza",
    "Medycyna morska i tropikalna",
    "Medycyna nuklearna",
    "Medycyna paliatywna",
    "Medycyna pracy",
    "Medycyna ratunkowa",
    "Medycyna rodzinna",
    "Medycyna sądowa",
    "Medycyna sportowa",
    "Mikrobiologia lekarska",
    "Nefrologia",
    "Nefrologia dziecięca",
    "Neonatologia",
    "Neurochirurgia",
    "Neurologia",
    "Neurologia dziecięca",
    "Neuropatologia",
    "Okulistyka",
    "Onkologia i hematologia dziecięca",
    "Onkologia kliniczna",
    "Ortopedia i traumatologia narządu ruchu",
    "Otorynolaryngologia",
    "Otorynolaryngologia dziecięca",
    "Patomorfologia",
    "Pediatria",
    "Pediatria metaboliczna",
    "Perinatologia",
    "Położnictwo i ginekologia",
    "Psychiatria",
    "Psychiatria dzieci i młodzieży",
    "Radiologia i diagnostyka obrazowa",
    "Radioterapia onkologiczna",
    "Rehabilitacja medyczna",
    "Reumatologia",
    "Seksuologia",
    "Toksykologia kliniczna",
    "Transfuzjologia kliniczna",
    "Transplantologia kliniczna",
    "Urologia",
    "Urologia dziecięca",
    "Zdrowie publiczne",
]


class Neo4jGenerator:
    __data = []
    __substances = []
    __pharmaceutical_forms = []
    __doctors = []
    __patients = []
    __pharmacies = []
    __specializations = []
    __allergies = []
    __pharmaciests = []
    __categories = []
    __medicines = []

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

    def delete_all(conn):
        query = """
                MATCH (n)
                DETACH DELETE n
                """
        conn.query(query)

    def add_to_query(self, query, parameters=None):
        self.__data.append((query, parameters))

    def query(self, query, parameters=None, db=None):
        self.add_to_query(query, parameters)
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

    def execute_queries(conn):
        with conn.__driver.session() as session:
            for query, parameters in tqdm(conn.__data, desc="Executing queries"):
                session.run(query, parameters)

    def create_doctor_and_user(conn):
        first_name = fake.first_name()
        last_name = fake.last_name()
        pesel = fake.ssn()
        pzw_number = fake.bothify(text="#######")
        phone_number = fake.phone_number()
        email = fake.email()
        login = fake.user_name()
        password = fake.password()
        is_admin = False

        query = """
                CREATE (d:Doctor {first_name: $first_name, last_name: $last_name, pesel: $pesel, pzw_number: $pzw_number})
                CREATE (u:User {phone_number: $phone_number, email: $email, login: $login, password: $password, is_admin: $is_admin})
                MERGE (d)-[:HAVE]->(u)
                """
        conn.add_to_query(
            query,
            parameters={
                "first_name": first_name,
                "last_name": last_name,
                "pesel": pesel,
                "pzw_number": pzw_number,
                "phone_number": phone_number,
                "email": email,
                "login": login,
                "password": password,
                "is_admin": is_admin,
            },
        )

        conn.__doctors.append(pesel)
        for _ in tqdm(
            range(random.randint(1, 5)),
            desc="Adding specializations to doctor",
            position=1,
            leave=False,
        ):
            Neo4jGenerator.add_specialization_to_doctor(conn, pesel)

    def add_specialization_to_doctor(conn, pesel):
        specialization_id = conn.__specializations[
            random.randint(0, len(conn.__specializations) - 1)
        ]
        issue_date = fake.date_between(start_date="-10y", end_date="today")

        query = """
                MATCH (d:Doctor {pesel: $pesel})
                MATCH (s:Specialization {name: $specialization_id})
                CREATE (d)-[:OBTAINED {issue_date: $issue_date}]->(s)
                """
        conn.add_to_query(
            query,
            parameters={
                "pesel": pesel,
                "specialization_id": specialization_id,
                "issue_date": issue_date.isoformat(),
            },
        )

    def create_patient_and_user(conn):
        first_name = fake.first_name()
        last_name = fake.last_name()
        pesel = fake.ssn()
        phone_number = fake.phone_number()
        email = fake.email()
        login = fake.user_name()
        password = fake.password()
        is_admin = False

        query = """
                CREATE (p:Patient {first_name: $first_name, last_name: $last_name, pesel: $pesel})
                CREATE (u:User {phone_number: $phone_number, email: $email, login: $login, password: $password, is_admin: $is_admin})
                MERGE (p)-[:HAVE]->(u)
                """
        conn.add_to_query(
            query,
            parameters={
                "first_name": first_name,
                "last_name": last_name,
                "pesel": pesel,
                "phone_number": phone_number,
                "email": email,
                "login": login,
                "password": password,
                "is_admin": is_admin,
            },
        )
        conn.__patients.append(pesel)
        for _ in tqdm(
            range(random.randint(1, 5)),
            desc="Adding allergies to patient",
            position=1,
            leave=False,
        ):
            Neo4jGenerator.add_allergy_to_patient(conn, pesel)

    def add_allergy_to_patient(conn, pesel):
        allergy_id = conn.__allergies[random.randint(0, len(conn.__allergies) - 1)]

        query = """
                MATCH (p:Patient {pesel: $pesel})
                MATCH (a:Allergy {name: $allergy_id})
                CREATE (p)-[:HAVE]->(a)
                """
        conn.add_to_query(
            query,
            parameters={
                "pesel": pesel,
                "allergy_id": allergy_id,
            },
        )

    def create_pharmacist_and_user(conn):
        first_name = fake.first_name()
        last_name = fake.last_name()
        pesel = fake.ssn()
        pzwf_number = fake.bothify(text="#######")
        phone_number = fake.phone_number()
        email = fake.email()
        login = fake.user_name()
        password = fake.password()
        is_admin = False

        query = """
                CREATE (p:Pharmacist {first_name: $first_name, last_name: $last_name, pesel: $pesel, pzwf_number: $pzwf_number})
                CREATE (u:User {phone_number: $phone_number, email: $email, login: $login, password: $password, is_admin: $is_admin})
                MERGE (p)-[:HAVE]->(u)
                """
        conn.__pharmaciests.append(pesel)
        conn.add_to_query(
            query,
            parameters={
                "first_name": first_name,
                "last_name": last_name,
                "pesel": pesel,
                "pzwf_number": pzwf_number,
                "phone_number": phone_number,
                "email": email,
                "login": login,
                "password": password,
                "is_admin": is_admin,
            },
        )

    def create_pharmacy(conn, num_of_pharmaciests=5):
        name = fake.company()
        address = fake.address()
        phone_number = fake.phone_number()
        permit_number = fake.bothify(text="#######")

        query = """
                CREATE (p:Pharmacy {name: $name, address: $address, phone_number: $phone_number, permit_number: $permit_number})
                """

        conn.add_to_query(
            query,
            parameters={
                "name": name,
                "address": address,
                "phone_number": phone_number,
                "permit_number": permit_number,
            },
        )
        conn.__pharmacies.append(permit_number)
        for i in tqdm(
            range(random.randint(1, num_of_pharmaciests)),
            desc="Adding pharmacists to pharmacy",
            position=1,
            leave=False,
        ):
            Neo4jGenerator.create_pharmacist_to_pharmacy(conn, permit_number)

    def create_pharmacist_to_pharmacy(conn, permit_number):
        pharmacist_id = conn.__pharmaciests[
            random.randint(0, len(conn.__pharmaciests) - 1)
        ]
        query = """
                MATCH (pha:Pharmacy {permit_number: $permit_number})
                MATCH (phst:Pharmacist {pesel: $pharmacist_id})
                CREATE (phst)-[:WORK_IN]->(pha)
                """
        conn.add_to_query(
            query,
            parameters={
                "permit_number": permit_number,
                "pharmacist_id": pharmacist_id,
            },
        )

    def create_specializations(conn):
        for name in tqdm(SPECIALIZATIONS, desc="Creating specializations"):
            query = """
                    Create (s:Specialization {name: $name})
                    """
            conn.add_to_query(
                query,
                parameters={
                    "name": name,
                },
            )
            conn.__specializations.append(name)

    def create_allergy(conn):
        name = fake.word()
        description = fake.text()

        query = """
                Create (a:Allergy {name: $name, description: $description})
                """
        conn.add_to_query(
            query,
            parameters={
                "name": name,
                "description": description,
            },
        )
        conn.__allergies.append(name)

    def create_categories(conn):
        for key, value in tqdm(
            CATEGORIES.items(), desc="Adding categories", position=0, leave=True
        ):
            query = """
                    Create (c:Category {symbol: $symbol, description: $description})
                    """
            conn.add_to_query(
                query,
                parameters={
                    "symbol": key,
                    "description": value,
                },
            )
            conn.__categories.append(key)
            for _ in tqdm(
                range(random.randint(1, 5)),
                desc="Adding specializations to category",
                position=1,
                leave=False,
            ):
                Neo4jGenerator.create_specialization_to_category(conn, key)

    def create_specialization_to_category(conn, category):
        specialization_id = conn.__specializations[
            random.randint(0, len(conn.__specializations) - 1)
        ]

        query = """
                MATCH (c:Category {symbol: $category})
                MATCH (s:Specialization {name: $specialization_id})
                CREATE (s)-[:PERMITS]->(c)
                """

        conn.add_to_query(
            query,
            parameters={
                "category": category,
                "specialization_id": specialization_id,
            },
        )

    def create_pharmaceutical_form(conn):
        name = fake.word()
        query = """
                CREATE (pf:PharmaceuticalForm {name: $name})
                """
        conn.add_to_query(
            query,
            parameters={
                "name": name,
            },
        )
        conn.__pharmaceutical_forms.append(name)

    def create_substance(conn):
        name = fake.word()
        query = """
                CREATE (s:Substance {name: $name})
                """
        conn.add_to_query(
            query,
            parameters={
                "name": name,
            },
        )
        conn.__substances.append(name)
        for _ in tqdm(
            range(random.randint(1, 5)),
            desc="Adding pharmaceutical forms to substance",
            position=1,
            leave=False,
        ):
            Neo4jGenerator.add_allergy_to_substance(conn, name)

    def add_allergy_to_substance(conn, substance_name):
        allergy_id = conn.__allergies[random.randint(0, len(conn.__allergies) - 1)]

        query = """
                MATCH (s:Substance {name: $substance_name})
                MATCH (a:Allergy {name: $allergy_id})
                CREATE (a)-[:ALLERGY_TO]->(s)
                """
        conn.add_to_query(
            query,
            parameters={
                "substance_name": substance_name,
                "allergy_id": allergy_id,
            },
        )

    def create_medicine(conn):
        permit_number = fake.bothify(text="#######")
        name = fake.word()

        query = """
                CREATE (m:Medicine {permit_number: $permit_number, name: $name})
                """

        conn.add_to_query(
            query,
            parameters={
                "permit_number": permit_number,
                "name": name,
            },
        )

        pharmaceutical_form_id = conn.__pharmaceutical_forms[
            random.randint(0, len(conn.__pharmaceutical_forms) - 1)
        ]

        query = """
                MATCH (m:Medicine {permit_number: $permit_number})
                MATCH (pf:PharmaceuticalForm {name: $pharmaceutical_form_id})
                CREATE (m)-[:IS]->(pf)
                """

        conn.add_to_query(
            query,
            parameters={
                "permit_number": permit_number,
                "pharmaceutical_form_id": pharmaceutical_form_id,
            },
        )

        category_id = conn.__categories[random.randint(0, len(conn.__categories) - 1)]

        query = """
                MATCH (m:Medicine {permit_number: $permit_number})
                MATCH (c:Category {symbol: $category_id})
                CREATE (m)-[:TYPE]->(c)
                """

        conn.add_to_query(
            query,
            parameters={
                "permit_number": permit_number,
                "category_id": category_id,
            },
        )

        conn.__medicines.append(permit_number)

        for _ in tqdm(
            range(random.randint(1, 5)),
            desc="Adding substances to medicine",
            position=1,
            leave=False,
        ):
            Neo4jGenerator.add_substance_to_medicine(conn, permit_number)

    def add_substance_to_medicine(conn, permit_number):
        substance_id = conn.__substances[random.randint(0, len(conn.__substances) - 1)]

        query = """
                MATCH (m:Medicine {permit_number: $permit_number})
                MATCH (s:Substance {name: $substance_id})
                CREATE (m)-[:CONTAINS]->(s)
                """

        conn.add_to_query(
            query,
            parameters={
                "permit_number": permit_number,
                "substance_id": substance_id,
            },
        )

    def create_prescription(conn):
        patient_id = conn.__patients[random.randint(0, len(conn.__patients) - 1)]

        doctor_id = conn.__doctors[random.randint(0, len(conn.__doctors) - 1)]

        medicine_id = conn.__medicines[random.randint(0, len(conn.__medicines) - 1)]

        issue_date = fake.date_between(start_date="-10y", end_date="today")
        expiration_date = fake.date_between(start_date=issue_date, end_date="+1y")
        annotation = fake.text()
        status = random.choice(["realized", "not_realized", "expired"])
        if status == "realized":
            realization_date = fake.date_between(start_date=issue_date, end_date="+1y")
        else:
            realization_date = None

        dosage = random.randint(1, 5)
        quantity = random.randint(1, 5)

        query = """
                MATCH (p:Patient {pesel: $patient_id})
                MATCH (d:Doctor {pesel: $doctor_id})
                MATCH (m:Medicine {permit_number: $medicine_id})
                CREATE (pre:Prescription {expiration_date: $expiration_date, annotation: $annotation, status: $status})
                CREATE (pre)-[:ISSUED_BY {issue_date: $issue_date}]->(d)
                CREATE (pre)-[:OF {dosage: $dosage, quantity: $quantity}]->(m)
                CREATE (pre)-[:FOR]->(p)
                """
        if realization_date != None:
            pharmacy_id = conn.__pharmacies[
                random.randint(0, len(conn.__pharmacies) - 1)
            ]
            query += """
                    WITH pre
                    MATCH (ph:Pharmacy {permit_number: $pharmacy_id})
                    CREATE (ph)-[:REALIZED {realization_date: $realization_date}]->(pre)
                    """
            conn.add_to_query(
                query,
                parameters={
                    "patient_id": patient_id,
                    "doctor_id": doctor_id,
                    "medicine_id": medicine_id,
                    "issue_date": issue_date.isoformat(),
                    "expiration_date": expiration_date.isoformat(),
                    "annotation": annotation,
                    "status": status,
                    "dosage": dosage,
                    "quantity": quantity,
                    "realization_date": realization_date.isoformat(),
                    "pharmacy_id": pharmacy_id,
                },
            )
        else:
            conn.add_to_query(
                query,
                parameters={
                    "patient_id": patient_id,
                    "doctor_id": doctor_id,
                    "medicine_id": medicine_id,
                    "issue_date": issue_date.isoformat(),
                    "expiration_date": expiration_date.isoformat(),
                    "annotation": annotation,
                    "status": status,
                    "dosage": dosage,
                    "quantity": quantity,
                },
            )
