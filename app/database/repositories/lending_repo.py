from app.database.connection import db_cursor
from app.database.models.lending import Lending

def get_by_id(lending_id: int) -> Lending | None:
    with db_cursor() as (_, cur):
        cur.execute("SELECT * FROM lendings WHERE lending_id = %s", (lending_id,))
        row = cur.fetchone()
    return Lending(**row) if row else None

def get_for_book(book_id: int, status: str | None=None) -> list[Lending]:
    with db_cursor() as (_, cur):
        if status:
            cur.execute(
                "SELECT * FROM lendings WHERE book_id = %s AND status = %s::lending_status",
                (book_id, status),
            )
        else:
            cur.execute("SELECT * FROM lendings WHERE book_id = %s", (book_id,))
        rows = cur.fetchall()
    return [Lending(**r) for r in rows]

def get_for_user(user_id: int) -> list[dict]:
    with db_cursor() as (_, cur):
        cur.execute(
            """
            SELECT l.*, b.title, b.author, u.username AS owner_username
            FROM lendings l
            JOIN books b ON l.book_id = b.book_id
            LEFT JOIN book_collection bc ON bc.book_id = l.book_id
            LEFT JOIN users u ON bc.user_id = u.user_id
            WHERE l.borrowing_user_id = %s
            ORDER BY l.reservation_date DESC
            """,
            (user_id,),
        )
        return [dict(r) for r in cur.fetchall()]

def get_incoming_requests(owner_user_id: int) -> list[dict]:
    """Lending requests for books owned by this user."""
    with db_cursor() as (_, cur):
        cur.execute(
            """
            SELECT l.*, b.title, b.author, u.username AS borrower_username
            FROM lendings l
            JOIN books b ON l.book_id = b.book_id
            JOIN book_collection bc ON bc.book_id = l.book_id AND bc.user_id = %s
            JOIN users u ON l.borrowing_user_id = u.user_id
            WHERE l.status IN ('Reserved', 'Lent')
            ORDER BY l.reservation_date DESC
            """,
            (owner_user_id,),
        )
        return [dict(r) for r in cur.fetchall()]

def create_reservation(borrowing_user_id: int, book_id: int) -> Lending:
    with db_cursor() as (_, cur):
        cur.execute(
            """
            INSERT INTO lendings (borrowing_user_id, book_id, reservation_date, status)
            VALUES (%s, %s, NOW(), 'Reserved')
            RETURNING *
            """,
            (borrowing_user_id, book_id),
        )
        row = cur.fetchone()
    return Lending(**row)

def update_status(lending_id: int, status: str) -> None:
    with db_cursor() as (_, cur):
        cur.execute(
            "UPDATE lendings SET status = %s::lending_status WHERE lending_id = %s",
            (status, lending_id),
        )


def set_lent(lending_id: int) -> None:
    with db_cursor() as (_, cur):
        cur.execute(
            "UPDATE lendings SET status = 'Lent', lent_date = NOW() WHERE lending_id = %s",
            (lending_id,),
        )


def set_returned(lending_id: int) -> None:
    with db_cursor() as (_, cur):
        cur.execute(
            "UPDATE lendings SET status = 'Returned', return_date = NOW() WHERE lending_id = %s",
            (lending_id,),
        )
