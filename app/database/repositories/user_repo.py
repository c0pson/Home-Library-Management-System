from app.database.connection import db_cursor
from app.database.models.user import User


def get_by_id(user_id: int) -> User | None:
    with db_cursor() as (_, cur):
        cur.execute("SELECT * FROM users WHERE user_id = %s", (user_id,))
        row = cur.fetchone()
    return User(**row) if row else None

def get_by_username(username: str) -> User | None:
    with db_cursor() as (_, cur):
        cur.execute("SELECT * FROM users WHERE username = %s", (username,))
        row = cur.fetchone()
    return User(**row) if row else None

def create(username: str, password_hash: str) -> User:
    with db_cursor() as (_, cur):
        cur.execute(
            "INSERT INTO users (username, password_hash) VALUES (%s, %s) RETURNING *",
            (username, password_hash),
        )
        row = cur.fetchone()
    return User(**row)

def delete(user_id: int) -> None:
    with db_cursor() as (_, cur):
        cur.execute("DELETE FROM users WHERE user_id = %s", (user_id,))

def get_friends(user_id: int) -> list[User]:
    with db_cursor() as (_, cur):
        cur.execute(
            """
            SELECT DISTINCT u.*
            FROM users u
            JOIN friends f
              ON (f.friend_id = u.user_id AND f.user_id = %s)
              OR (f.user_id   = u.user_id AND f.friend_id = %s)
            """,
            (user_id, user_id),
        )
        rows = cur.fetchall()
    return [User(**r) for r in rows]

def are_friends(user_id: int, friend_id: int) -> bool:
    with db_cursor() as (_, cur):
        cur.execute(
            """
            SELECT 1 FROM friends
            WHERE (user_id = %s AND friend_id = %s)
               OR (user_id = %s AND friend_id = %s)
            """,
            (user_id, friend_id, friend_id, user_id),
        )
        return cur.fetchone() is not None

def add_friend(user_id: int, friend_id: int) -> None:
    with db_cursor() as (_, cur):
        cur.execute(
            "INSERT INTO friends (user_id, friend_id) VALUES (%s, %s)",
            (user_id, friend_id),
        )

def remove_friend(user_id: int, friend_id: int) -> None:
    with db_cursor() as (_, cur):
        cur.execute(
            """
            DELETE FROM friends
            WHERE (user_id = %s AND friend_id = %s)
               OR (user_id = %s AND friend_id = %s)
            """,
            (user_id, friend_id, friend_id, user_id),
        )

def search(query: str) -> list[User]:
    with db_cursor() as (_, cur):
        cur.execute(
            "SELECT * FROM users WHERE username ILIKE %s ORDER BY username",
            (f"%{query}%",),
        )
        rows = cur.fetchall()
    return [User(**r) for r in rows]
