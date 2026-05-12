from app.database.repositories import book_repo, inbox_repo, lending_repo
from app.database.models.lending import Lending

def get_user_lendings(user_id: int) -> list[dict]:
    return lending_repo.get_for_user(user_id)

def get_incoming_requests(user_id: int) -> list[dict]:
    return lending_repo.get_incoming_requests(user_id)

def reserve_book(
    borrowing_user_id: int, collection_id: int
) -> tuple[Lending | None, str | None]:
    item = book_repo.get_collection_item(collection_id)
    if not item:
        return None, "Book not found in collection."

    if item["user_id"] == borrowing_user_id:
        return None, "You cannot reserve your own book."

    active = lending_repo.get_for_book(item["book_id"], "Reserved")
    if active:
        return None, "Book is already reserved."

    lending = lending_repo.create_reservation(borrowing_user_id, item["book_id"])
    inbox_repo.send(
        item["user_id"],
        "LendingRequest",
        f"Someone wants to borrow \"{item['title']}\".",
    )
    return lending, None

def confirm_lending(
    lending_id: int, owner_user_id: int
) -> tuple[bool, str | None]:
    lending = lending_repo.get_by_id(lending_id)
    if not lending or lending.status != "Reserved":
        return False, "Invalid lending request."
    lending_repo.set_lent(lending_id)
    inbox_repo.send(
        lending.borrowing_user_id,
        "LendingAccepted",
        "Your lending request was accepted.",
    )
    return True, None

def decline_lending(
    lending_id: int, owner_user_id: int
) -> tuple[bool, str | None]:
    lending = lending_repo.get_by_id(lending_id)
    if not lending or lending.status != "Reserved":
        return False, "Invalid lending request."
    lending_repo.update_status(lending_id, "Cancelled")
    inbox_repo.send(
        lending.borrowing_user_id,
        "LendingDeclined",
        "Your lending request was declined.",
    )
    return True, None

def request_return(
    lending_id: int, borrower_user_id: int
) -> tuple[bool, str | None]:
    lending = lending_repo.get_by_id(lending_id)
    if not lending or lending.status != "Lent":
        return False, "No active lending found."
    if lending.borrowing_user_id != borrower_user_id:
        return False, "Not authorized."
    lending_repo.set_returned(lending_id)
    return True, None
