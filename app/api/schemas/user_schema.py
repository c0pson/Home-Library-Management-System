def validate_register(data: dict) -> dict:
    errors = {}
    username = data.get("username", "").strip()
    password = data.get("password", "")

    if not username:
        errors["username"] = "Username is required."
    elif len(username) < 3 or len(username) > 50:
        errors["username"] = "Username must be 3-50 characters."

    if not password:
        errors["password"] = "Password is required."
    elif len(password) < 6:
        errors["password"] = "Password must be at least 6 characters."

    return errors

def validate_login(data: dict) -> dict:
    errors = {}
    if not data.get("username", "").strip():
        errors["username"] = "Username is required."
    if not data.get("password", ""):
        errors["password"] = "Password is required."
    return errors
