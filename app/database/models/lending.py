from dataclasses import dataclass
from datetime import datetime
from typing import Optional


@dataclass
class Lending:
    lending_id: int
    borrowing_user_id: int
    book_id: int
    status: str
    reservation_date: Optional[datetime] = None
    lent_date: Optional[datetime] = None
    return_date: Optional[datetime] = None
