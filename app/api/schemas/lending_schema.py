def validate_reserve(data: dict) -> dict:
    errors = {}
    if not data.get("collection_id"):
        errors["collection_id"] = "Collection item is required."
    return errors
