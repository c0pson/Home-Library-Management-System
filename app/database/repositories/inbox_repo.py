from app.database.connection import db_cursor
from app.database.models.inbox import InboxMessage

def get_for_user(user_id: int) -> list[InboxMessage]:
    with db_cursor() as (_, cur):
        cur.execute(
            "SELECT * FROM inbox_messages WHERE recipient_id = %s ORDER BY sent_at DESC",
            (user_id,),
        )
        rows = cur.fetchall()
    return [InboxMessage(**r) for r in rows]

def get_by_id(message_id: int) -> InboxMessage | None:
    with db_cursor() as (_, cur):
        cur.execute(
            "SELECT * FROM inbox_messages WHERE message_id = %s", (message_id,)
        )
        row = cur.fetchone()
    return InboxMessage(**row) if row else None

def send(recipient_id: int, msg_type: str, content: str) -> InboxMessage:
    with db_cursor() as (_, cur):
        cur.execute(
            """
            INSERT INTO inbox_messages (recipient_id, type, content)
            VALUES (%s, %s::inbox_message_type, %s)
            RETURNING *
            """,
            (recipient_id, msg_type, content),
        )
        row = cur.fetchone()
    return InboxMessage(**row)

def mark_read(message_id: int, user_id: int) -> None:
    with db_cursor() as (_, cur):
        cur.execute(
            "UPDATE inbox_messages SET read = TRUE WHERE message_id = %s AND recipient_id = %s",
            (message_id, user_id),
        )

def unread_count(user_id: int) -> int:
    with db_cursor() as (_, cur):
        cur.execute(
            "SELECT COUNT(*) AS cnt FROM inbox_messages WHERE recipient_id = %s AND read = FALSE",
            (user_id,),
        )
        row = cur.fetchone()
    return row["cnt"] if row else 0
