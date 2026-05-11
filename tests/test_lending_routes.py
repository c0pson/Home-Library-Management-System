import pytest

# (ok) login_required()
# index()
# (ok) reserve()
#       -  unsure about the error messages when invalid post is sent. 
# (ok) confirm()
#       - ok Positive lending
#       - ok Confirm non existing 
#       - Confirm from other user
# (ok) decline()
#       - ok Positive decline
#       - ok Non-Existing
#       - Decline by other user
# return_book()
#       - ok Positive return
#       - Non-Existing
#       - Returned by different user

#       - returned can be borrowed again

# DONE
def test_login_required_lending(client):
    with client:
        response = client.get("/lending/")
        assert response.status_code == 302
        assert response.headers["Location"] == "/login"

        response = client.post("/lending/reserve/1")
        assert response.status_code == 302
        assert response.headers["Location"] == "/login"

        response = client.post("/lending/confirm/1")
        assert response.status_code == 302
        assert response.headers["Location"] == "/login"

        response = client.post("/lending/decline/1")
        assert response.status_code == 302
        assert response.headers["Location"] == "/login"

        response = client.post("/lending/return/1")
        assert response.status_code == 302
        assert response.headers["Location"] == "/login"

# DONE
def test_reserve_lending(client, create_users_with_books, db_conn, auth):
    # 0. Users with books

    data = create_users_with_books
    print(data)

    user = data["users"][0]
    user_2 = data["users"][1]
    book = data['books'][1][0]

    auth.login(user["username"], user["password"])

    # 1. user1 reserves Hau-2 from user2

    response = client.post(f"/lending/reserve/{book['collection_id']}")

    # 2. Check redirect

    assert response.status_code == 302
    assert response.headers["Location"] == "/books/browse"

    # 3. Check DB

    # 3.1 lendings -> 1 lending

    with db_conn.cursor() as cur:
        cur.execute("SELECT * FROM lendings WHERE borrowing_user_id=(%s) AND book_id=(%s)",
                    (user["user_id"], book["book_id"]))
        lendings = cur.fetchall()

        assert len(lendings) == 1
        assert lendings[0]['status'] == "Reserved"

        # 3.2 User inbox_messages

        cur.execute("SELECT * FROM inbox_messages WHERE recipient_id=(%s)", 
                    (user_2["user_id"],))
        messages = cur.fetchall()

        assert len(messages) == 1
        assert messages[0]["read"] == False
        assert messages[0]["type"] == "LendingRequest"

# DONE 
def test_reserve_lending_invalid(client, create_users_with_books, db_conn, auth):
    ''' Test if DB is clean after invalid reservation request. '''
    
    # 0. Users with books

    data = create_users_with_books
    print(data)

    user = data["users"][0]
    user_2 = data["users"][1]
    book = data['books'][1][0]

    auth.login(user["username"], user["password"])

    # 1. user1 reserves Hau-2 from user2

    response = client.post(f"/lending/reserve/1234")

    # 2. Check redirect

    assert response.status_code == 302
    assert response.headers["Location"] == "/books/browse"

    # 3. Check DB

    # 3.1 lendings -> 1 lending

    with db_conn.cursor() as cur:
        cur.execute("SELECT * FROM lendings WHERE borrowing_user_id=(%s) AND book_id=(%s)",
                    (user["user_id"], book["book_id"]))
        lendings = cur.fetchall()

        assert len(lendings) == 0

        # 3.2 User inbox_messages

        cur.execute("SELECT * FROM inbox_messages WHERE recipient_id=(%s)", 
                    (user_2["user_id"],))
        messages = cur.fetchall()

        assert len(messages) == 0

# DONE
def test_confirm_lending(client, create_users_with_books, db_conn, auth):
    ''' Tests if book status & message status are updated after confirmation of lending. '''

    # 0. Preapre users & books

    data = create_users_with_books
    print(data)

    user = data["users"][0]
    user_2 = data["users"][1]
    book = data['books'][1][0]

    auth.login(user["username"], user["password"])

    # 1. Order a lent

    client.post(f"/lending/reserve/{book['book_id']}")

    # 2. Confirm lent

    with db_conn.cursor() as cur:
        cur.execute("SELECT * FROM lendings WHERE borrowing_user_id=(%s) AND book_id=(%s)",
                    (user["user_id"], book["book_id"]))
        lendings = cur.fetchone()

    response = client.post(f"/lending/confirm/{lendings['lending_id']}")

    # 3. Check redirect

    assert response.status_code == 302
    assert response.headers["Location"] == "/lending/"

    # 4. Check DB

    with db_conn.cursor() as cur:
        cur.execute("SELECT * FROM lendings WHERE borrowing_user_id=(%s) AND book_id=(%s)",
                    (user["user_id"], book["book_id"]))
        lendings = cur.fetchall()

        assert len(lendings) == 1
        assert lendings[0]["status"] == "Lent"

        # 3.2 User inbox_messages

        cur.execute("SELECT * FROM inbox_messages WHERE recipient_id=(%s) AND type=(%s)", 
                    (user["user_id"], "LendingAccepted"))
        messages = cur.fetchall()

        assert len(messages) == 1

# DONE
def test_confirm_lending_invalid(client, create_users_with_books, db_conn, auth):
    ''' Tests if book status & message status are updated after confirmation of lending. '''

    # 0. Preapre users & books

    data = create_users_with_books
    print(data)

    user = data["users"][0]
    user_2 = data["users"][1]
    book = data['books'][1][0]

    auth.login(user["username"], user["password"])

    # 1. Order a lent

    client.post(f"/lending/reserve/{book['book_id']}")

    # 2. Confirm lent

    with db_conn.cursor() as cur:
        cur.execute("SELECT * FROM lendings WHERE borrowing_user_id=(%s) AND book_id=(%s)",
                    (user["user_id"], book["book_id"]))
        lendings = cur.fetchone()

    response = client.post(f"/lending/confirm/1234")

    # 3. Check redirect

    assert response.status_code == 302
    assert response.headers["Location"] == "/lending/"

    # 4. Check DB

    with db_conn.cursor() as cur:
        # 3.2 User inbox_messages

        cur.execute("SELECT * FROM inbox_messages WHERE recipient_id=(%s)", 
                    (user["user_id"],))
        messages = cur.fetchall()

        assert len(messages) == 0

# DONE
def test_decline_lending(client, create_users_with_books, db_conn, auth):
    ''' Tests if declining borrow request message status and book status are set. '''
    
    # 0. Preapre users & books

    data = create_users_with_books
    print(data)

    user = data["users"][0]
    user_2 = data["users"][1]
    book = data['books'][1][0]

    auth.login(user["username"], user["password"])

    # 1. Order a lent

    client.post(f"/lending/reserve/{book['book_id']}")

    # 2. Confirm lent

    with db_conn.cursor() as cur:
        cur.execute("SELECT * FROM lendings WHERE borrowing_user_id=(%s) AND book_id=(%s)",
                    (user["user_id"], book["book_id"]))
        lendings = cur.fetchone()

    response = client.post(f"/lending/decline/{lendings['lending_id']}")

    # 3. Check redirect

    assert response.status_code == 302
    assert response.headers["Location"] == "/lending/"

    # 4. Check DB

    with db_conn.cursor() as cur:
        # 3.1 Book status

        cur.execute("SELECT * FROM lendings WHERE borrowing_user_id=(%s) AND book_id=(%s)",
                    (user["user_id"], book["book_id"]))
        lendings = cur.fetchall()

        assert len(lendings) == 1
        assert lendings[0]["status"] == "Cancelled"

        # 3.2 User inbox_messages

        cur.execute("SELECT * FROM inbox_messages WHERE recipient_id=(%s)", 
                    (user["user_id"],))
        messages = cur.fetchall()

        assert len(messages) == 1
        assert messages[0]["type"] == "LendingDeclined"

# DONE
def test_decline_lending_invalid(client, create_users_with_books, db_conn, auth):
    ''' Tests if DB remains untouched after non-existing lending is declined. '''
    
    # 0. Preapre users & books

    data = create_users_with_books
    print(data)

    user = data["users"][0]
    user_2 = data["users"][1]
    book = data['books'][1][0]

    auth.login(user["username"], user["password"])

    # 1. Order a lent

    client.post(f"/lending/reserve/{book['book_id']}")

    # 2. Confirm lent

    with db_conn.cursor() as cur:
        cur.execute("SELECT * FROM lendings WHERE borrowing_user_id=(%s) AND book_id=(%s)",
                    (user["user_id"], book["book_id"]))
        lendings = cur.fetchone()

    response = client.post(f"/lending/decline/1234")

    # 3. Check redirect

    assert response.status_code == 302
    assert response.headers["Location"] == "/lending/"

    # 4. Check DB

    with db_conn.cursor() as cur:
        # 3.1 lendings table untouched
        cur.execute("SELECT * FROM lendings WHERE borrowing_user_id=(%s) AND book_id=(%s)",
                    (user["user_id"], book["book_id"]))
        lendings = cur.fetchall()

        assert len(lendings) == 1
        assert lendings[0]['status'] == "Reserved"

        # 3.2 User inbox_messages

        cur.execute("SELECT * FROM inbox_messages WHERE recipient_id=(%s)", 
                    (user["user_id"],))
        messages = cur.fetchall()

        assert len(messages) == 0

# DONE
def test_return_book_lending(client, create_users_with_books, db_conn, auth):
    ''' Tests is book returning updates a collection status. '''

    # 0. Preapre users & books

    data = create_users_with_books
    print(data)

    user = data["users"][0]
    user_2 = data["users"][1]
    book = data['books'][1][0]

    auth.login(user["username"], user["password"])

    # 1. Order a lent

    client.post(f"/lending/reserve/{book['book_id']}")

    # 2. Return book

    with db_conn.cursor() as cur:
        cur.execute("SELECT * FROM lendings WHERE borrowing_user_id=(%s) AND book_id=(%s)",
                    (user["user_id"], book["book_id"]))
        lendings = cur.fetchone()

    client.post(f"/lending/confirm/{lendings['lending_id']}")
    response = client.post(f"/lending/return/{lendings['lending_id']}")

    # 3. Check redirect

    assert response.status_code == 302
    assert response.headers["Location"] == "/lending/"

    # 4. Check DB

    with db_conn.cursor() as cur:
        # 4.1 Book status

        cur.execute("SELECT * FROM lendings WHERE borrowing_user_id=(%s) AND book_id=(%s)",
                    (user["user_id"], book["book_id"]))
        lendings = cur.fetchall()

        assert len(lendings) == 1
        assert lendings[0]["status"] == "Returned"






