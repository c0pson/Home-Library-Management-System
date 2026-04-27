from dataclasses import dataclass
from datetime import date, datetime

@dataclass
class Book:
    book_id: int
    title: str
    author: str
    release_date: date | None = None
    language: str | None = None
    genre: str | None = None
    isbn_13: str | None = None
    isbn_10: str | None = None

@dataclass
class BookCollection:
    collection_id: int
    user_id: int
    book_id: int
    added_at: datetime | None = None
    condition: str | None = None
