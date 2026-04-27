"""
Seed the database with realistic fake data using Faker.

Run from the project root:
    python database/seed.py

All seeded users share the password: password123
"""

import os
import random
import sys

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from faker import Faker

from app.database.connection import get_connection
from app.utils.security import hash_password

fake = Faker()

GENRES = [
    "Fiction", "Non-Fiction", "Science Fiction", "Fantasy",
    "Mystery", "Thriller", "Romance", "Biography", "History", "Science",
]
LANGUAGES  = [
    "English", "Polish", "German", "French", "Spanish"
]
CONDITIONS = [
    "New", "Good", "Fair", "Poor"
]
MSG_TYPES  = [
    "LendingRequest", "LendingAccepted", "LendingDeclined",
    "ReturnRequest", "ReturnConfirmed", "ReturnReminder",
]

def seed_users(conn, count: int = 10) -> list[dict]:
    users = []
    pw_hash = hash_password("password123")
    with conn.cursor() as cur:
        for _ in range(count):
            username = fake.unique.user_name()[:50]
            cur.execute(
                "INSERT INTO users (username, password_hash) VALUES (%s, %s) RETURNING user_id, username",
                (username, pw_hash),
            )
            users.append(dict(cur.fetchone()))
    conn.commit()
    print(f"  users         : {len(users)}")
    return users

def seed_books(conn, count: int = 30) -> list[dict]:
    books = []
    with conn.cursor() as cur:
        for _ in range(count):
            isbn13 = fake.numerify("9780#########")
            isbn10 = fake.numerify("##########")
            cur.execute(
                """
                INSERT INTO books (title, author, release_date, language, genre, isbn_13, isbn_10)
                VALUES (%s, %s, %s, %s, %s, %s, %s)
                RETURNING book_id, title
                """,
                (
                    fake.catch_phrase()[:255],
                    fake.name(),
                    fake.date_between(start_date="-100y", end_date="today"),
                    random.choice(LANGUAGES),
                    random.choice(GENRES),
                    isbn13,
                    isbn10,
                ),
            )
            books.append(dict(cur.fetchone()))
    conn.commit()
    print(f"  books         : {len(books)}")
    return books

def seed_collection(conn, users: list, books: list) -> list[int]:
    ids = []
    with conn.cursor() as cur:
        for user in users:
            sample = random.sample(books, random.randint(2, min(6, len(books))))
            for book in sample:
                try:
                    cur.execute(
                        "INSERT INTO book_collection (user_id, book_id, condition) VALUES (%s, %s, %s) RETURNING collection_id",
                        (user["user_id"], book["book_id"], random.choice(CONDITIONS)),
                    )
                    ids.append(cur.fetchone()["collection_id"])
                    conn.commit()
                except Exception:
                    conn.rollback()
    print(f"  collection    : {len(ids)}")
    return ids

def seed_friendships(conn, users: list) -> int:
    count = 0
    pairs: set[tuple] = set()
    with conn.cursor() as cur:
        for user in users:
            candidates = [u for u in users if u["user_id"] != user["user_id"]]
            for friend in random.sample(candidates, min(3, len(candidates))):
                pair = tuple(sorted((user["user_id"], friend["user_id"])))
                if pair in pairs:
                    continue
                pairs.add(pair)
                try:
                    cur.execute(
                        "INSERT INTO friends (user_id, friend_id) VALUES (%s, %s)",
                        (user["user_id"], friend["user_id"]),
                    )
                    conn.commit()
                    count += 1
                except Exception:
                    conn.rollback()
    print(f"  friendships   : {count}")
    return count

def seed_lendings(conn, users: list, books: list, count: int = 20) -> int:
    created = 0
    statuses = ["Reserved", "Lent", "Returned", "Cancelled"]
    with conn.cursor() as cur:
        for _ in range(count):
            borrower = random.choice(users)
            book = random.choice(books)
            status = random.choice(statuses)
            lent_date   = fake.date_time_between(start_date="-6m") if status in ("Lent", "Returned", "Overdue") else None
            return_date = fake.date_time_between(start_date="-3m") if status == "Returned" else None
            try:
                cur.execute(
                    """
                    INSERT INTO lendings
                        (borrowing_user_id, book_id, reservation_date, lent_date, return_date, status)
                    VALUES (%s, %s, %s, %s, %s, %s::lending_status)
                    """,
                    (
                        borrower["user_id"],
                        book["book_id"],
                        fake.date_time_between(start_date="-1y"),
                        lent_date,
                        return_date,
                        status,
                    ),
                )
                conn.commit()
                created += 1
            except Exception:
                conn.rollback()
    print(f"  lendings      : {created}")
    return created

def seed_inbox(conn, users: list) -> int:
    count = 0
    with conn.cursor() as cur:
        for user in users:
            for _ in range(random.randint(1, 5)):
                try:
                    cur.execute(
                        """
                        INSERT INTO inbox_messages (recipient_id, type, content, read)
                        VALUES (%s, %s::inbox_message_type, %s, %s)
                        """,
                        (
                            user["user_id"],
                            random.choice(MSG_TYPES),
                            fake.sentence(),
                            random.choice([True, False]),
                        ),
                    )
                    conn.commit()
                    count += 1
                except Exception:
                    conn.rollback()
    print(f"  inbox messages: {count}")
    return count

def main():
    print("Seeding database...")
    conn = get_connection()
    try:
        users = seed_users(conn, count=10)
        books = seed_books(conn, count=30)
        seed_collection(conn, users, books)
        seed_friendships(conn, users)
        seed_lendings(conn, users, books, count=20)
        seed_inbox(conn, users)
        print("Done. All seeded users have password: password123")
    finally:
        conn.close()

if __name__ == "__main__":
    main()
