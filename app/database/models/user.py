from dataclasses import dataclass
from datetime import datetime

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
    since: datetime | None = None
