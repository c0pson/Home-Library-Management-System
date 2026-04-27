from dataclasses import dataclass
from datetime import datetime

@dataclass
class Lending:
    lending_id: int
    borrowing_user_id: int
    book_id: int
    status: str
    reservation_date: datetime | None = None
    lent_date: datetime | None = None
    return_date: datetime | None = None
