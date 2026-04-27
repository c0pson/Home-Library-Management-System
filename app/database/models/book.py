from dataclasses import dataclass
from datetime import date, datetime
from typing import Optional


@dataclass
class Book:
    book_id: int
    title: str
    author: str
    release_date: Optional[date] = None
    language: Optional[str] = None
    genre: Optional[str] = None
    isbn_13: Optional[str] = None
    isbn_10: Optional[str] = None


@dataclass
class BookCollection:
    collection_id: int
    user_id: int
    book_id: int
    added_at: Optional[datetime] = None
    condition: Optional[str] = None
