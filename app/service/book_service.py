from app.database.repositories import book_repo
from app.database.models.book import Book, BookCollection

def get_all_books(search: str | None=None, sort_by: str = "title") -> list[Book]:
    return book_repo.get_all(search=search, sort_by=sort_by)

def get_book(book_id: int) -> Book | None:
    return book_repo.get_by_id(book_id)

def create_book(data: dict) -> Book:
    return book_repo.create(
        title=data["title"],
        author=data["author"],
        release_date=data.get("release_date") or None,
        language=data.get("language") or None,
        genre=data.get("genre") or None,
        isbn_13=data.get("isbn_13") or None,
        isbn_10=data.get("isbn_10") or None,
    )

def get_user_collection(user_id: int) -> list[dict]:
    return book_repo.get_collection(user_id)

def add_to_collection(
    user_id: int, book_id: int, condition: str|None=None
) -> tuple[BookCollection | None, str | None]:
    if not book_repo.get_by_id(book_id):
        return None, "Book not found."
    item = book_repo.add_to_collection(user_id, book_id, condition)
    return item, None

def remove_from_collection(collection_id: int, user_id: int) -> None:
    book_repo.remove_from_collection(collection_id, user_id)

def get_available_books() -> list[dict]:
    return book_repo.get_available_books()
