from app.database.connection import db_cursor
from app.database.models.book import Book, BookCollection

_SORTABLE = {"title", "author", "genre", "language", "release_date"}

def get_all(search: str | None=None, sort_by: str = "title") -> list[Book]:
    col = sort_by if sort_by in _SORTABLE else "title"
    with db_cursor() as (_, cur):
        if search:
            cur.execute(
                f"SELECT * FROM books WHERE title ILIKE %s OR author ILIKE %s ORDER BY {col}",
                (f"%{search}%", f"%{search}%"),
            )
        else:
            cur.execute(f"SELECT * FROM books ORDER BY {col}")
        rows = cur.fetchall()
    return [Book(**r) for r in rows]

def get_by_id(book_id: int) -> Book | None:
    with db_cursor() as (_, cur):
        cur.execute("SELECT * FROM books WHERE book_id = %s", (book_id,))
        row = cur.fetchone()
    return Book(**row) if row else None

def create(title: str, author: str, **kwargs) -> Book:
    with db_cursor() as (_, cur):
        cur.execute(
            """
            INSERT INTO books (title, author, release_date, language, genre, isbn_13, isbn_10)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
            RETURNING *
            """,
            (
                title, author,
                kwargs.get("release_date") or None,
                kwargs.get("language") or None,
                kwargs.get("genre") or None,
                kwargs.get("isbn_13") or None,
                kwargs.get("isbn_10") or None,
            ),
        )
        row = cur.fetchone()
    return Book(**row)

def get_collection(user_id: int) -> list[dict]:
    with db_cursor() as (_, cur):
        cur.execute(
            """
            SELECT bc.collection_id, bc.user_id, bc.added_at, bc.condition,
                   b.book_id, b.title, b.author, b.genre, b.language
            FROM book_collection bc
            JOIN books b ON bc.book_id = b.book_id
            WHERE bc.user_id = %s
            ORDER BY b.title
            """,
            (user_id,),
        )
        return [dict(r) for r in cur.fetchall()]

def get_collection_item(collection_id: int) -> dict | None:
    with db_cursor() as (_, cur):
        cur.execute(
            """
            SELECT bc.collection_id, bc.user_id, bc.book_id, bc.condition,
                   b.title, b.author
            FROM book_collection bc
            JOIN books b ON bc.book_id = b.book_id
            WHERE bc.collection_id = %s
            """,
            (collection_id,),
        )
        row = cur.fetchone()
    return dict(row) if row else None

def add_to_collection(user_id: int, book_id: int, condition: str | None=None) -> BookCollection:
    with db_cursor() as (_, cur):
        cur.execute(
            "INSERT INTO book_collection (user_id, book_id, condition) VALUES (%s, %s, %s) RETURNING *",
            (user_id, book_id, condition),
        )
        row = cur.fetchone()
    return BookCollection(**row)

def remove_from_collection(collection_id: int, user_id: int) -> None:
    with db_cursor() as (_, cur):
        cur.execute(
            "DELETE FROM book_collection WHERE collection_id = %s AND user_id = %s",
            (collection_id, user_id),
        )

def get_available_books() -> list[dict]:
    """All collection entries whose books are not currently Reserved or Lent."""
    with db_cursor() as (_, cur):
        cur.execute(
            """
            SELECT bc.collection_id, bc.user_id, bc.condition,
                   b.book_id, b.title, b.author, b.genre, b.language,
                   u.username AS owner_username
            FROM book_collection bc
            JOIN books b ON bc.book_id = b.book_id
            JOIN users u ON bc.user_id = u.user_id
            WHERE bc.book_id NOT IN (
                SELECT book_id FROM lendings WHERE status IN ('Reserved', 'Lent')
            )
            ORDER BY b.title
            """
        )
        return [dict(r) for r in cur.fetchall()]
