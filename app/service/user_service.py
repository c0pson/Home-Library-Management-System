from app.database.repositories import user_repo
from app.utils.security import hash_password, verify_password
from app.database.models.user import User

def register(username: str, password: str) -> tuple[User | None, str | None]:
    if user_repo.get_by_username(username):
        return None, "Username already taken."
    user = user_repo.create(username, hash_password(password))
    return user, None

def login(username: str, password: str) -> tuple[User | None, str | None]:
    user = user_repo.get_by_username(username)
    if not user or not verify_password(password, user.password_hash):
        return None, "Invalid username or password."
    return user, None

def get_profile(user_id: int) -> User | None:
    return user_repo.get_by_id(user_id)

def get_friends(user_id: int) -> list[User]:
    return user_repo.get_friends(user_id)

def add_friend(user_id: int, friend_id: int) -> tuple[bool, str | None]:
    if user_id == friend_id:
        return False, "You cannot add yourself as a friend."
    if user_repo.are_friends(user_id, friend_id):
        return False, "Already friends."
    if not user_repo.get_by_id(friend_id):
        return False, "User not found."
    user_repo.add_friend(user_id, friend_id)
    return True, None

def remove_friend(user_id: int, friend_id: int) -> None:
    user_repo.remove_friend(user_id, friend_id)

def search_users(query: str) -> list[User]:
    return user_repo.search(query)
