"""
Shared pytest fixtures.

Provides reusable test setup: Flask test client, database
connections with automatic rollback, and sample data factories
(users, books, friendships). Auto discovered by pytest,
any test function can request these fixtures by parameter name.
"""

import pytest
from app import create_app
from app.database.connection import get_connection, db_cursor
@pytest.fixture()
def app():
    app = create_app()
    app.config.update({
        "TESTING" : True,
    })
    yield app

@pytest.fixture()
def client(app):
    return app.test_client()

@pytest.fixture()
def runner(app):
    return app.test_cli_runner()

@pytest.fixture()
def db_conn(app):
    conn = get_connection()
    yield conn
    conn.close()

@pytest.fixture()
def db_cursor(db_conn):
    with db_conn.cursor() as cur:
        yield cur
        db_conn.rollback()

class AuthActions(object):
    def __init__(self, client):
        self._client = client

    def login_new(self, username="Little_Mi", password="Moomin"):
        ''' Registers a new user and stays logged in. '''
        return self._client.post("/register", data = {
            "username" : username,
            "password" : password
        })

    def login(self, username="annamunoz", password="password123"):
        ''' Logins and existing user. '''
        return self._client.post(
            "/login",
            data={
                "username" : username,
                "password" : password
            }
        )
    
    def logout(self):
        return self._client.get("/logout")
    
@pytest.fixture()
def auth(client):
    return AuthActions(client)

@pytest.fixture()
def add_user(db_conn, client):
    ''' Registers new user and logs them out. '''
    def add_user(username="test1", password="test_password"):
        with db_conn.cursor() as cur:
            client.post(
                "/register",
                data = {
                "username" : username,
                "password" : password
                }
            )
            client.get("/logout")
            cur.execute(
                    "SELECT * FROM users WHERE username=(%s)",
                    (username,)
                )
            db_conn.commit()
            id = cur.fetchone()["user_id"]
            return {"user_id" : id, "username" : username, "password" : password}

    return add_user

@pytest.fixture()
def add_book(db_conn, client):
    ''' Adds a book into DB & logged useres collection. Requires isbn-13 to work. '''

    def new_book(title = "book-1", new_data=None):

        data = {
            "author"       : "author-1",
            "release_date" : "12-12-2012",
            "language"     : "English",
            "genre"        : "SCI-FI",
            "isbn_13"      : "1234567890123",
            "isbn_10"      : "1234567890"   
        }

        data["title"] = title

        if new_data:
            data = new_data

        client.post("/books/add", data=data)

        with db_conn.cursor() as cur:
            cur.execute("SELECT * FROM books WHERE isbn_13=(%s)", (data["isbn_13"],))
            db_conn.commit()
            return cur.fetchall()[0]

    return new_book

@pytest.fixture()
def create_users_with_books(auth, add_book, add_user, db_conn):
    ''' Creates 3 test users, each with set of 3 books. '''

    # 0. Dummy users & books

    # user-1 user-2
    users = [
        ["user1", "password1"],
        ["user2", "password2"]
    ]

    # author -1-2-3-4
    # English French German
    # Sci-fi Fantasy Science
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
                "title"        : "Quack-2",
                "author"       : "author-3",
                "release_date" : "12-12-2013",
                "language"     : "English",
                "genre"        : "Science",
                "isbn_13"      : "1234567890125",
                "isbn_10"      : "1234567895"   
            },
        ]
    ]

    users_data = []

    books_data = []

    for i in range(2):
        # 1. Create & login user
        users_data.append(add_user(users[i][0], users[i][1]))
        auth.login(users[i][0], users[i][1])

        # 2. Add books for the user

        books_data.append([])
        for b in books[i]:
            
            temp = add_book(new_data=b)

            # 2.1 Find the collection id to which the book belongs
            with db_conn.cursor() as cur:
                cur.execute("SELECT * FROM book_collection WHERE user_id=(%s) AND book_id=(%s)",
                            (users_data[-1]["user_id"], temp["book_id"]))
                collection_id = cur.fetchall()[0]["collection_id"]

                assert collection_id != None
                temp["collection_id"] = collection_id

            # 2.2 Insert book data into registry

            books_data[i].append(temp)

        auth.logout()

    # 3. Return users and books data

    yield {
        "users" : users_data,
        "books" : books_data
    }

@pytest.fixture(autouse=True)
def clear_users(db_conn):
    """ Cleans the users table & removes contents binded by foreign keys. """
    with db_conn.cursor() as cur:
        cur.execute("TRUNCATE TABLE users RESTART IDENTITY CASCADE")

    db_conn.commit()

@pytest.fixture(autouse=True)
def clear_books(db_conn):
    ''' Cleans the books table and removes content binded with foreign keys. '''
    with db_conn.cursor() as cur:
        cur.execute("TRUNCATE TABLE books RESTART IDENTITY CASCADE")

    db_conn.commit()





