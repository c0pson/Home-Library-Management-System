from dataclasses import dataclass
from datetime import datetime

@dataclass
class InboxMessage:
    message_id: int
    recipient_id: int
    type: str
    content: str
    sent_at: datetime | None = None
    read: bool = False
