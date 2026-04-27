def validate_message(data: dict) -> dict:
    errors = {}
    if not data.get("content", "").strip():
        errors["content"] = "Message content is required."
    return errors
