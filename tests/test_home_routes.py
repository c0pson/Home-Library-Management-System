import pytest
from flask import session

# (ok) index()
# dashboard()

# DONE
def test_index(client, auth, add_user):
    # 0. Login user

    add_user("user1", "password1")
    auth.login("user1", "password1")

    # 1. Test redirect

    response = client.get("/")
    assert response.status_code == 302
    assert response.headers["Location"] == "/dashboard"

    # 2. Logout redirect

    auth.logout()

    response = client.get("/")
    assert response.status_code == 302
    assert response.headers["Location"] == "/login"

#IN PROGRESS
def test_dashboard(client, auth, add_user):
    #-2. Add user

    add_user("user1", "password1")
    
    #-1. Test login_required

    response = client.get("/dashboard")
    
    assert response.status_code == 302
    assert response.headers["Location"] == "/login"

    # 0. Test if all books in collection
    # 1. Test if all lendings listed
    # 2. Test if all incoming listed
    # 3. Test if all unread listed

    assert True


