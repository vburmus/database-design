from generator import Neo4jGenerator
from dotenv import load_dotenv
import os
from tqdm import tqdm


load_dotenv()

NUMBER_OF_DOCTORS = 2_000
NUMBER_OF_PATIENTS = 4_000
NUMBER_OF_PHARMACISTS = 1_000
NUMBER_OF_PHARMACYS = 600
ALLERGIES_AMOUNT = 100
PHARMACEUTICAL_FORMS_AMOUNT = 250
SUBSTANCES_AMOUNT = 5_000
MEDICINES_AMOUNT = 10_000
PRESCRIPTIONS_AMOUNT = 10_000

if __name__ == "__main__":
    generator = Neo4jGenerator(
        os.getenv("DB_HOST"), os.getenv("DB_LOGIN"), os.getenv("DB_PASSWORD")
    )
    generator.delete_all()
    for i in tqdm(range(NUMBER_OF_PHARMACISTS), desc="Creating pharmacists"):
        generator.create_pharmacist_and_user()
    for i in tqdm(
        range(NUMBER_OF_PHARMACYS), desc="Creating pharmacys", position=0, leave=True
    ):
        generator.create_pharmacy()

    generator.create_specializations()
    for i in tqdm(
        range(ALLERGIES_AMOUNT), desc="Creating allergies", position=0, leave=True
    ):
        generator.create_allergy()

    generator.create_categories()

    for i in tqdm(
        range(PHARMACEUTICAL_FORMS_AMOUNT),
        desc="Creating pharmaceutical forms",
        position=0,
        leave=True,
    ):
        generator.create_pharmaceutical_form()
    for i in tqdm(
        range(SUBSTANCES_AMOUNT), desc="Creating substances", position=0, leave=True
    ):
        generator.create_substance()
    for i in tqdm(
        range(MEDICINES_AMOUNT), desc="Creating medicines", position=0, leave=True
    ):
        generator.create_medicine()
    for i in tqdm(
        range(NUMBER_OF_DOCTORS), desc="Creating doctors", position=0, leave=True
    ):
        generator.create_doctor_and_user()
    for i in tqdm(
        range(NUMBER_OF_PATIENTS), desc="Creating patients", position=0, leave=True
    ):
        generator.create_patient_and_user()
    for i in tqdm(
        range(PRESCRIPTIONS_AMOUNT),
        desc="Creating prescriptions",
        position=0,
        leave=True,
    ):
        generator.create_prescription()
    generator.execute_queries()
    print("Done!")
    generator.close()
