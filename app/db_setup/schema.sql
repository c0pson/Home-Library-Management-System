CREATE TABLE users (
    user_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username TEXT CONSTRAINT u_constr CHECK ((char_length(username) >= 3) AND (char_length(username) <= 50)) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL 
);

CREATE TABLE inbox_messages (
    message_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    recipient_id INTEGER REFERENCES users (user_id) ON DELETE CASCADE NOT NULL,
    i_type TEXT CONSTRAINT type_constr CHECK ((char_length(i_type) >= 1) AND (char_length(i_type) <= 50)) NOT NULL, --changed from type due to being a keyword
    content TEXT CONSTRAINT cont_constr CHECK ((char_length(content) >= 1) AND (char_length(content) <= 255)) NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_read BOOLEAN DEFAULT FALSE NOT NULL --changed from read due to being a keyword
);

CREATE TABLE friends (
    friendship_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INTEGER REFERENCES users (user_id) ON DELETE CASCADE NOT NULL,
    friend_id INTEGER REFERENCES users (user_id) ON DELETE CASCADE NOT NULL,
    since DATE DEFAULT CURRENT_DATE NOT NULL,
    CHECK (user_id < friend_id), --saves space, one friendship per two users, tougher checks though, because two instead of one
    UNIQUE(user_id, friend_id)
);

CREATE TABLE books (
    book_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title TEXT CONSTRAINT title_constr CHECK ((char_length(title) >= 1) AND (char_length(title) <= 255)) NOT NULL,
    author TEXT CONSTRAINT a_constr CHECK ((char_length(author) >= 1) AND (char_length(author) <= 255)) NOT NULL,
    release_date DATE,
    language TEXT CONSTRAINT lang_constr CHECK ((char_length(language) >= 3) AND (char_length(language) <= 50)),
    genre TEXT CONSTRAINT gen_constr CHECK ((char_length(genre) >= 3) AND (char_length(genre) <= 100)),
    isbn_13 VARCHAR(13),
    isbn_10 VARCHAR(10)
);

CREATE TABLE book_collection (
    collection_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INTEGER REFERENCES users (user_id) ON DELETE CASCADE NOT NULL,
    book_id INTEGER REFERENCES books (book_id) ON DELETE RESTRICT NOT NULL, ---what if it is already lent? and in someone else's collection
    --do we add a is_borrowed value? or check the lendings table each time...
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    condition TEXT CONSTRAINT cond_constr CHECK (condition IN ('new', 'good', 'fair', 'poor')) NOT NULL
);

CREATE TABLE lendings (
    lending_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    borrowing_user_id INTEGER REFERENCES users (user_id) ON DELETE CASCADE NOT NULL,
    book_id INTEGER REFERENCES book_collection (collection_id) ON DELETE CASCADE NOT NULL,
    reservation_date DATE NOT NULL, --CONSTRAINT res_constr CHECK (reservation_date >= CURRENT_DATE) NOT NULL,
    lent_date DATE, --CONSTRAINT lent_constr CHECK (lent_date >= CURRENT_DATE), --can be different than reservation date, maybe the owner wanted to give the user the book earlier
    return_date DATE CONSTRAINT ret_constr CHECK (return_date >= lent_date),
    status TEXT CONSTRAINT stat_constr CHECK (status IN ('reserved', 'lent', 'returned', 'cancelled', 'overdue')) NOT NULL
);

TRUNCATE TABLE
  lendings,
  inbox_messages,
  friends,
  book_collection,
  books,
  users
RESTART IDENTITY CASCADE;
