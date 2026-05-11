import pytest
from app.database.connection import get_connection, db_cursor

def test_connection_up(db_conn):
    with db_conn.cursor() as cur:
        cur.execute("SELECT 1;")
        result = cur.fetchone()

        assert result["?column?"] == 1

def test_db_name():
    with db_cursor() as (conn, cur):
        cur.execute("SELECT current_database();")
        db_name = cur.fetchone()["current_database"]
        assert db_name == "test_library"

    