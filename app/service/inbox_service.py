from app.database.repositories import inbox_repo
from app.database.models.inbox import InboxMessage

def get_inbox(user_id: int) -> list[InboxMessage]:
    return inbox_repo.get_for_user(user_id)

def mark_read(message_id: int, user_id: int) -> bool:
    msg = inbox_repo.get_by_id(message_id)
    if not msg or msg.recipient_id != user_id:
        return False
    inbox_repo.mark_read(message_id, user_id)
    return True

def get_unread_count(user_id: int) -> int:
    return inbox_repo.unread_count(user_id)
