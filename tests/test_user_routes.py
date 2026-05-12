import pytest
from flask import session
from werkzeug.security import check_password_hash

# TODO
# 1. (ok) Register
# 2. Persist user (fixture) -> fix this
# 3. (ok) Logout
# 4. (ok) Login

# For friends functions -> create class -> constant set of users
# 5. (ok) @login_required 
# 6. (ok) friends
# 7. (ok) add_friend
# 8. (ok) remove_friend

# Test manually typed urls
# Logged in user types /register
# User manually types /add/1231231
# User manually type /remove/1234234

# Take a look at geminis suggestions

# Automate testing with class

# -------------- Register -------------- #

# DONE
def test_register(client, db_conn):
    ''' Tests the correct working of /register endpoint. '''
    with client:
        # 0. Check if route is responsive
        assert client.get("/register").status_code == 200

        # 1. Try to register new client

        username = "meow"
        password = "asdfgh"

        response = client.post("/register", data={
            "username" : username,
            "password" : password
        })

        # 2. Check redirect to dashboard

        assert response.status_code == 302
        assert response.headers["Location"] == "/dashboard"

        # 3. Check database

        with db_conn.cursor() as cur:
            cur.execute("SELECT * FROM users where username=(%s)", ((username,)))
            new_user = cur.fetchone()
            assert new_user is not None
            assert new_user["username"] == username
            assert check_password_hash(new_user["password_hash"], password)

        # 4. Check session

        assert session["username"] == username
        assert session["user_id"] == new_user["user_id"]

# DONE
@pytest.mark.parametrize(
        ("username", "password", "message"),(
        ("", "", "Username is required."),
        ("a", "", "Username must be 3-50 characters."),
        ("test1", "", "Password is required."),
        ("test1", "test", "Password must be at least 6 characters."),)
)
def test_validate_register(client, username, password, message):
    ''' Tests invalid working of /register endpoint. '''

    with client:
        # 0. Is route responsive

        assert client.get("/register").status_code == 200
    
        # 1. Try to register new client

        response = client.post(
            "/register",
            data = {
                "username" : username,
                "password" : password
            }
        )

        # 2. Check redirect

        assert message.encode("utf-8") in response.data

# DONE
def test_register_username_taken(client, add_user):
    ''' Tests /register endpoint for duplicated registers. '''

    with client:
        # 0. Is route responsive

        assert client.get("/register").status_code == 200
    
        # 1. Try to register duplicated client
        #add_user("test1", "test_password")
        client.post(
            "/register",
            data = {
                "username" : "test1",
                "password" : "test_password"
            }
        )
        client.get("/logout")
        response = client.post(
            "/register",
            data = {
                "username" : "test1",
                "password" : "test_password"
            }
        )

        # 2. Check redirect

        assert b'Username already taken.' in response.data

# -------------- Logout -------------- #

# DONE
def test_logout(client, auth, add_user):
    with client:
        # 0. Login new user
        
        add_user("test1", "test_password")
        auth.login("test1", "test_password")

        # 1. Logout user

        response = client.get("/logout")

        assert response.headers["Location"] == "/login"
        assert len(session) == 0

# -------------- Login -------------- #

# DONE
def test_login(client, add_user):
    ''' Tests if existing user can succesfully log in. '''
    with client:
    # 0. Add new user

        data = add_user()
        
    # 1. Log the user in

        assert client.get("/login").status_code == 200

        response = client.post("/login", data={
                        "username" : data["username"],
                        "password" : data["password"]
                    })

        assert response.status_code == 302
        assert response.headers["Location"] == "/dashboard"

    # 2. Test session

        assert session["user_id"] == data["user_id"]
        assert session["username"] == data["username"]

    # 3. Repeated login

        response = client.post("/login", data={
                        "username" : data["username"],
                        "password" : data["password"]
                    })
        
        assert response.status_code == 302
        assert response.headers["Location"] == "/dashboard"

    # 4. Invalid login for existing user

    client.get("/logout")
    response = client.post("/login", data={
                        "username" : data["username"],
                        "password" : "wrong_password"
                    })
    
    assert b"Invalid username or password." in response.data

    # 5. Logged in tries to register

  #  response = client.get("/register")

  #  assert response.status_code == 302
  #  assert response.headers["Location"] == "/dashboard"

# DONE
@pytest.mark.parametrize(("username", "password", "message"),(
        ("", "", "Username is required."),
        ("test1", "", "Password is required."),
        ("test1", "invalid_password", "Invalid username or password."),
        ("not_existing_user", "with_not_existing_password", "Invalid username or password."),
))
def test_false_login(username, password, message, client):
    ''' Tests if invalid credentials are rejected. '''

    with client:
        response = client.post("/login", data={
            "username" : username,
            "password" : password
        })

        assert message.encode("utf-8") in response.data

# -------------- Friends -------------- #

# DONE
def test_add_friend(client, add_user, auth, db_conn):
    ''' Tests adding a valid friend. '''
    # 0. Add 2 users

    data_1 = add_user("user1", "password1")
    data_2 = add_user("user2", "password2")

    # 1. A befriends B
    
    with client:

        # 1.1 Login as A

        auth.login("user1", "password1")
        response = client.post(f"/friends/add/{data_2['user_id']}")

        # 1.2 Check redirect

        assert response.status_code == 302
        assert response.headers["Location"] == "/friends"

        # 1.3 Check DB

        with db_conn.cursor() as cur:
            cur.execute(
                "SELECT * FROM friends WHERE user_id=(%s)",
                (data_1["user_id"],))
            friends = cur.fetchall()

            assert len(friends) == 1
            assert data_2["user_id"] == friends[0]["friend_id"]

# DONE
def test_add_friend_self(client, add_user, auth, db_conn):
    ''' Tests if its possible to add self as friend to DB. '''
    with client:
        data = add_user("user1", "password1")
        auth.login("user1", "password1")
        response = client.post(f"/friends/add/{data['user_id']}")

        with db_conn.cursor() as cur:
            cur.execute("SELECT * FROM friends where user_id=(%s)", (data["user_id"],))
            friends = cur.fetchall()

            assert len(friends) == 0

# DONE
def test_add_friend_not_existing(client, add_user, auth, db_conn):
    ''' Tests if its possible to add user who does not exist in DB as friend. '''
    with client:
        data = add_user("user1", "password1")
        auth.login("user1", "password1")
        response = client.post(f"/friends/add/{42}")

        with db_conn.cursor() as cur:
            cur.execute("SELECT * FROM friends where user_id=(%s)", (data["user_id"],))
            friends = cur.fetchall()

            assert len(friends) == 0

# DONE
def test_add_friend_duplicate(client, add_user, auth, db_conn):
    ''' Tests if its possible to add friend again as friend. '''
    with client:
        data_1 = add_user("user1", "password1")
        data_2 = add_user("user2", "password2")

        auth.login("user1", "password1")
        response = client.post(f"/friends/add/{data_2['user_id']}")
        response = client.post(f"/friends/add/{data_2['user_id']}")

        with db_conn.cursor() as cur:
            cur.execute("SELECT * FROM friends where user_id=(%s)", (data_1["user_id"],))
            friends = cur.fetchall()

            assert len(friends) == 1

# DONE
def test_remove_friend(client, add_user, auth, db_conn):

    with client:
        # 0. Add 2 users

        data_1 = add_user("user1", "password1")
        data_2 = add_user("user2", "password2")

        auth.login("user1", "password1")

        # 1. A has friend B

        client.post(f"/friends/add/{data_2['user_id']}")

        with db_conn.cursor() as cur:
            cur.execute("SELECT * FROM friends WHERE user_id=(%s)",(data_1['user_id'],))
            friends = cur.fetchall()
            
            assert len(friends) == 1

            # 2. A removes friend B

            client.post(f"/friends/remove/{data_2['user_id']}")

            # 3. Validate DB

            cur.execute("SELECT * FROM friends WHERE user_id=(%s)",(data_1['user_id'],))
            friends = cur.fetchall()
            
            assert len(friends) == 0

# DONE
def test_friends(client, add_user, auth, db_conn):
    ''' Tests if necessary elements are passed into the template. '''

    # 0. Setup users

    add_user("user1", "password1")
    data_2 = add_user("user2", "password2")
    data_3 = add_user("user3", "password3")
    data_4 = add_user("user4", "password4")
    add_user("asdf", "password5")

    # 1. Login user

    auth.login("user1", "password1")

    # 2. Add friends

    client.post(f"/friends/add/{data_2['user_id']}")
    client.post(f"/friends/add/{data_3['user_id']}")
    response = client.post(f"/friends/add/{data_4['user_id']}", follow_redirects=True)

    # 3. All friends are listed
    print(response)
    print(response.headers)
    print(response.data)

    assert response.status_code == 200

    assert b"user2" in response.data
    assert b"user3" in response.data
    assert b"user4" in response.data

    # 4. Search for new friends

    response = client.get("/friends?q=a")
    assert b'asdf' in response.data

    response = client.get("/friends?q=u")

    # Check that noone is listed
    #assert b'asdf' in response.data

    # 5. One way friendship

    auth.logout()
    auth.login("user2", "password2")

    response = client.get("/friends")

    assert b"user1" in response.data

    # 6. XSS

    '''
    response = client.get("/friends?q=<script>alert('XSS ATTACK!')</script>")
    print(response)
    print(response.data)
    assert response.status_code != 500
    assert b"XSS ATTACK!" not in response.data
    '''

# -------------- login_required -------------- #

def test_login_required(client, auth):
    ''' Try to access all resources that require being logged in. '''

    with client:

        auth.logout()

        response = client.get("/friends")
        assert response.status_code == 302
        assert response.headers["Location"] == "/login"

        response = client.post("/friends/add/1")
        assert response.status_code == 302
        assert response.headers["Location"] == "/login"


        response = client.post("/friends/remove/1")
        assert response.status_code == 302
        assert response.headers["Location"] == "/login"






