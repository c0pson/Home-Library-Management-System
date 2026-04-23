import psycopg
from psycopg import sql, errors
import os
from dotenv import load_dotenv

load_dotenv()

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
SCHEMA_PATH = os.path.join(BASE_DIR, "schema.sql")
SEED_PATH = os.path.join(BASE_DIR, "seed.sql")

env_vars = {
    "DB_SUPERUSER": "postgres",
    "DB_SUPERPASS": "postgres",
    "DB_NAME": "database",
    "DB_PORT": 5432,
    "DB_USER": "dev",
    "DB_PASS": "devpass"
}

config = {key: os.getenv(key, default) for key, default in env_vars.items()}

# Connect to the template1 database and then create the database as superuser
with psycopg.connect (
    dbname="template1",
    user = config["DB_SUPERUSER"],
    autocommit = True,
    password = config["DB_SUPERPASS"],
    port = config["DB_PORT"],
    host = "localhost"
) as conn:
    with conn.cursor() as cur:
        
        cur.execute(sql.SQL("DROP DATABASE IF EXISTS {}").format(sql.Identifier(config['DB_NAME'])))
        # TODO: Replace print with logger
        print(f"Dropped database {config['DB_NAME']} if it existed")
        
        cur.execute(sql.SQL("CREATE DATABASE {}").format(sql.Identifier(config['DB_NAME'])))
        print(f"Created a database {config['DB_NAME']}")

# Connect to the created database as superuser, create a new user   
with psycopg.connect (
    dbname=config["DB_NAME"],
    user = config["DB_SUPERUSER"],
    autocommit = True,
    password = config["DB_SUPERPASS"],
    port = config["DB_PORT"],
    host = "localhost"
) as conn:
    with conn.cursor() as cur:
        # Safer for other DBs on the system
        try:
            cur.execute(
                sql.SQL("CREATE ROLE {} LOGIN PASSWORD {}").format(sql.Identifier(config['DB_USER']), sql.Literal(config['DB_PASS']))
            )        
        except errors.DuplicateObject:
            # TODO: replace with logger and better handling
            print(f"{config['DB_USER']} already exists")
        cur.execute(sql.SQL("GRANT ALL PRIVILEGES ON DATABASE {} TO {};").format(sql.Identifier(config['DB_NAME']), sql.Identifier(config['DB_USER']))) # Does not grant all permissions
        cur.execute(sql.SQL("GRANT USAGE, CREATE ON SCHEMA public TO {};").format(sql.Identifier(config['DB_USER']))) 
        print(f"Created user {config['DB_USER']} and granted privileges.")

# Create the table based on schema.sql and populate it with seed.sql data
with psycopg.connect(
    dbname=config["DB_NAME"],
    user = config["DB_USER"],
    autocommit = True,
    password = config["DB_PASS"],
    port = config["DB_PORT"],
    host = "localhost"
) as conn:
    with conn.cursor() as cur:
        cur.execute(open(SCHEMA_PATH,"r").read())
        print("Created tables from schema.sql")
        cur.execute(open(SEED_PATH,"r").read())
        print("Inserted seed values into the tables from seed.sql")
