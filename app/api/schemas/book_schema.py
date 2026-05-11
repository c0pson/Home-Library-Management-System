def validate_book(data: dict) -> dict:
    errors = {}

    if not data.get("title", "").strip():
        errors["title"] = "Title is required."

    if not data.get("author", "").strip():
        errors["author"] = "Author is required."

    isbn_13 = data.get("isbn_13", "").strip()
    if isbn_13 and len(isbn_13) != 13:
        errors["isbn_13"] = "ISBN-13 must be exactly 13 characters."

    isbn_10 = data.get("isbn_10", "").strip()
    if isbn_10 and len(isbn_10) != 10:
        errors["isbn_10"] = "ISBN-10 must be exactly 10 characters."

    return errors
