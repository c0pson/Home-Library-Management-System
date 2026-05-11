import pytest

# IMPORTANT
# - Search by year seems to be not working

# (ok) login_required()
# index()
# browse()
# (ok) add()
# (ok) collection()
# (ok) remove_from_collection()

# Test duplicate books

# DONE
@pytest.mark.parametrize(("route"),
                         (("/books/"),
                         ("/books/browse"),
                         ("/books/add"),
                         ("/books/collection"),
                         ))
def test_login_required_book_routes(route, client, auth):
    ''' Tests if some endpoints are protected against not-logged in acces. '''
    auth.logout()

    with client:
        response = client.get(route)
        assert response.status_code == 302
        assert response.headers["Location"] == "/login"

# DONE
def test_add_books(client, add_user, auth, db_conn):
    ''' Tests if user can add some valid book. '''
    # 0. Login user

    user_data = add_user("test1", "password1")
    auth.login("test1", "password1")

    # 1. Add a book

    response = client.post("/books/add", data={
        "title"        : "book-1",
        "author"       : "author-1",
        "release_date" : "12-12-2012",
        "language"     : "English",
        "genre"        : "SCI-FI",
        "isbn_13"      : "1234567890123",
        "isbn_10"      : "1234567890"
    })

    # 2. Check redirect

    assert response.status_code == 302
    assert response.headers["Location"] == "/books/collection"

    # 3. Check DB

    with db_conn.cursor() as cur:
        # 3.1 books table

        cur.execute("SELECT * FROM books WHERE isbn_13=(%s)", ("1234567890123",))
        books = cur.fetchall()

        assert len(books) == 1
        assert books[0]["title"] == "book-1"

        # 3.2 book_collection table

        cur.execute("SELECT * FROM book_collection WHERE user_id=(%s)", (user_data["user_id"],))
        collection = cur.fetchall()

        assert len(collection) == 1
        assert collection[0]["book_id"] == books[0]["book_id"]

# DONE
@pytest.mark.parametrize(("title", "author", "isbn_13", "isbn_10", "message"), (
        ("", "", "", "", "Title is required."),
        ("book-1", "", "", "", "Author is required."),
        ("book-1", "test author", "123", "", "ISBN-13 must be exactly 13 characters."),
        ("book-1", "test-author", "1234567890123", "123", "ISBN-10 must be exactly 10 characters."),
))
def test_add_books_validate(title, author, isbn_13, isbn_10, message, client, add_user, auth, db_conn):
    ''' Tests error messages for invalid book formats. '''
    # 0. Login user
    
    user_data = add_user("user1", "password1")
    auth.login("user1", "password1")

    # 1. Add invalid book

    response = client.post("/books/add", data={
        "title"        : title,
        "author"       : author,
        "release_date" : "12-12-2012",
        "language"     : "English",
        "genre"        : "SCI-FI",
        "isbn_13"      : isbn_13,
        "isbn_10"      : isbn_10
    })

    # 2. Message

    assert message.encode("utf-8") in response.data

    # 3. Check if DB emty

    with db_conn.cursor() as cur:
        cur.execute("SELECT * FROM books WHERE isbn_13=(%s)", (isbn_13,))
        books = cur.fetchall()
        
        assert len(books) == 0

# DONE 
def test_remove_from_collection(client, db_conn, auth, add_book, add_user):
    # 0. Login user & add book

    user_data = add_user("user1", "password1")
    auth.login("user1", "password1")
    book_data = add_book(title="book-1")
    add_book(title="book-2")

    # 1. Remove book

    # 1.1 Obtain collection ID

    with db_conn.cursor() as cur:
        cur.execute("SELECT * FROM book_collection WHERE user_id=(%s) AND book_id=(%s)", 
                    (user_data["user_id"], book_data["book_id"]))

        collection_id = cur.fetchall()[0]["collection_id"]

    response = client.post(f"/books/collection/remove/{collection_id}")

    assert response.status_code == 302
    assert response.headers["Location"] == "/books/collection"

    # 2. Validate DB

    with db_conn.cursor() as cur:

        # 2.1 Book remains, collection gone

        cur.execute("SELECT * FROM books")
        books = cur.fetchall()
        print(books)
        assert len(books) == 2

        cur.execute("SELECT * FROM book_collection WHERE user_id=(%s)", (user_data["user_id"],))
        coll = cur.fetchall()
        print(coll)
        assert len(coll) == 1

# DONE
def test_remove_from_collection_invalid(client, db_conn, auth, add_book, add_user):
    ''' Test if removal of a non-existing book does not affect the DB. '''
    # 0. Login user & add book

    user_data = add_user("user1", "password1")
    auth.login("user1", "password1")
    book_data = add_book(title="book-1")
    add_book(title="book-2")

    # 1. Remove non-existing book

    response = client.post(f"/books/collection/remove/1234")

    assert response.status_code == 302
    assert response.headers["Location"] == "/books/collection"

    # 2. Validate DB

    with db_conn.cursor() as cur:

        # 2.1 Book remains, collection gone

        cur.execute("SELECT * FROM books")
        assert len(cur.fetchall()) == 2

        cur.execute("SELECT * FROM book_collection WHERE user_id=(%s)", (user_data["user_id"],))
        assert len(cur.fetchall()) == 2

# DONE
def test_collection(client, auth, add_book, add_user):
    ''' Tests if books from user collection are listed in the frontend. '''
    # 0. Login user & add books

    user_data = add_user("user1", "password1")
    auth.login("user1", "password1")

    book_1 = add_book(title="Miau")
    book_2 = add_book(title="Hau")
    book_3 = add_book(title="kukuryku")

    # 1. Check frontend

    response = client.get("/books/collection")

    assert book_1["title"].encode("utf-8") in response.data
    assert book_2["title"].encode("utf-8") in response.data
    assert book_3["title"].encode("utf-8") in response.data

    # 1.1 Are they persisted?

    auth.logout()
    auth.login("user1", "password1")

    response = client.get("/books/collection")

    assert book_1["title"].encode("utf-8") in response.data
    assert book_2["title"].encode("utf-8") in response.data
    assert book_3["title"].encode("utf-8") in response.data

def test_browse_books(client, auth, add_book, add_user):
    ''' 
    Test if books of other users are visible in frontend. 
    Assumes all books are avaialble for borrow
    '''

    # 0. Prepare users

    users = [
        ["user1", "password1"],
        ["user2", "password2"],
        ["user3", "password3"]
    ]

    books = [
        ["book-1-1", "book-1-2", "book-1-3"],
        ["book-2-1", "book-2-2", "book-2-3"],
        ["book-3-1", "book-3-2", "book-3-3"],
    ]

    # 1. Add users & books

    for i in range(3):
        add_user(users[i][0], users[i][1])
        auth.login(users[i][0], users[i][1])
        for b in books[i]:
            add_book(title=b)
        auth.logout()

    # 2. Check if other users books are available

    auth.login(users[1][0], users[1][1])

    response = client.get("/books/browse")

    print(response.data)

    for i in [0, 2]:
        for b in books[i]:
            assert b.encode("utf-8") in response.data

# IN PROGRESS
def test_browse_books_some_not_avaialable():
    """ Tests if books not avaialable for borrow are not shown on the website. """
    pass

# IN PROGRESS
# - Search by genre, author & year not tested
def test_index_books(client, db_conn, auth, add_book, add_user):
    ''' Tests if searched books are displayed. '''

    # 0. Dummy users & books

    users = [
        ["user1", "password1"],
        ["user2", "password2"]
    ]

    # author -1-2-3-4
    # English French German
    # SCI-FI Fantasy Science
    # Meow-1-2 Hau-1-2 Quack-1-2

    books = [
        [
            {
                "title"        : "Meow-1",
                "author"       : "author-1",
                "release_date" : "01-01-2002",
                "language"     : "English",
                "genre"        : "Sci-fi",
                "isbn_13"      : "1234567890120",
                "isbn_10"      : "1234567890"   
            },
            {
                "title"        : "Meow-2",
                "author"       : "author-2",
                "release_date" : "12-11-2002",
                "language"     : "French",
                "genre"        : "Fantasy",
                "isbn_13"      : "1234567890121",
                "isbn_10"      : "1234567891"   
            },
            {
                "title"        : "Hau-1",
                "author"       : "author-2",
                "release_date" : "12-12-2012",
                "language"     : "English",
                "genre"        : "Science",
                "isbn_13"      : "1234567890122",
                "isbn_10"      : "1234567892"   
            },
         
        ],
        [
            {
                "title"        : "Hau-2",
                "author"       : "author-4",
                "release_date" : "01-12-2012",
                "language"     : "German",
                "genre"        : "Fantasy",
                "isbn_13"      : "1234567890123",
                "isbn_10"      : "1234567893"   
            },
            {
                "title"        : "Quack-1",
                "author"       : "author-4",
                "release_date" : "01-12-2012",
                "language"     : "German",
                "genre"        : "Sci-fi",
                "isbn_13"      : "1234567890124",
                "isbn_10"      : "1234567894"   
            },
            {
                "title"        : "Quack-1",
                "author"       : "author-3",
                "release_date" : "12-12-2013",
                "language"     : "English",
                "genre"        : "Science",
                "isbn_13"      : "1234567890125",
                "isbn_10"      : "1234567895"   
            },
        ]
    ]

    for i in range(2):
        add_user(users[i][0], users[i][1])
        auth.login(users[i][0], users[i][1])

        for b in books[i]:
            add_book(new_data=b)

        auth.logout()

    # 1. Empty search

    auth.login("user1", "password1")
    response = client.get("/books/")

    assert response.status_code == 200
    for a in books:
        for b in a:
            assert b["title"].encode("utf-8") in response.data
            assert b["author"].encode("utf-8") in response.data


    with db_conn.cursor() as cur:
        cur.execute("SELECT * FROM books")
        books = cur.fetchall()
        print(f"All books: {books}")

    # 2. Only searched books in results

    # 2.1 By title

    response = client.get("/books/?q=uac&sort=title")
    print(response.data)

    assert b"Quack-1" in response.data
    assert b"author-4" in response.data
    assert b"author-3" in response.data
    assert b"Meow-1" not in response.data

    # 2.2 By author

    response = client.get("/books/?q=2&sort=author")

    assert b"author-1" not in response.data
    assert b"author-2" in response.data

    # 2.3 By genre

    '''
    
    response = client.get("/books/?q=Sci&sort=genre")

    assert b"Meow-1" in response.data
    assert b"Quack-1" in response.data

    assert b"Hau-1" not in response.data
    assert b"Meow-2" not in response.data

    # 2.4 By language

    response = client.get("/books/?q=Eng&sort=language")

    assert b"Meow-1" in response.data
    assert b"Hau-1" in response.data
    assert b"Quack-1" in response.data

    assert b"Meow-2" not in response.data

    # 3.5 By Year 

    '''

    # 3.6 Not existing parameter

    response = client.get("/books/?q=asdnaksbhsdjhas&sort=title")

    assert b"Meow-1" not in response.data
    assert b"Meow-2" not in response.data
    assert b"Hau-1" not in response.data
    assert b"Hau-2" not in response.data
    assert b"Quack-1" not in response.data
    assert b"Quack-2" not in response.data









