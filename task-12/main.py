from generator import Neo4jGenerator
from dotenv import load_dotenv
import os

load_dotenv()

if __name__ == "__main__":
    generator = Neo4jGenerator(
        os.getenv("DB_HOST"), os.getenv("DB_LOGIN"), os.getenv("DB_PASSWORD")
    )
    generator.create_doctor()
    generator.close()
