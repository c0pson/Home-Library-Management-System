from dataclasses import dataclass
from datetime import datetime
from typing import Optional


@dataclass
class User:
    user_id: int
    username: str
    password_hash: str


@dataclass
class Friend:
    friendship_id: int
    user_id: int
    friend_id: int
    since: Optional[datetime] = None
