"""
Run from the project root:  python database/setup.py
Executes create_tables, indexes, and procedures SQL files in order.
"""

import os
import sys

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from app.database.connection import get_connection

BASE = os.path.dirname(__file__)

SCRIPTS = [
    os.path.join(BASE, "schema", "create_tables.sql"),
    os.path.join(BASE, "schema", "indexes.sql"),
    os.path.join(BASE, "functions", "procedures.sql"),
]

def run():
    conn = get_connection()
    try:
        with conn.cursor() as cur:
            for path in SCRIPTS:
                with open(path) as f:
                    sql = f.read().strip()
                if sql:
                    cur.execute(sql)
                    print(f"  OK  {os.path.basename(path)}")
        conn.commit()
        print("Database setup complete.")
    except Exception as exc:
        conn.rollback()
        print(f"Error: {exc}")
        sys.exit(1)
    finally:
        conn.close()

if __name__ == "__main__":
    run()
