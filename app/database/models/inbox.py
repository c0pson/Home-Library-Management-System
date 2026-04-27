from dataclasses import dataclass
from datetime import datetime
from typing import Optional


@dataclass
class InboxMessage:
    message_id: int
    recipient_id: int
    type: str
    content: str
    sent_at: Optional[datetime] = None
    read: bool = False
