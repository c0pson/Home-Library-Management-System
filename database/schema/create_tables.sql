CREATE TYPE lending_status AS ENUM ('Reserved', 'Lent', 'Returned', 'Cancelled', 'Overdue');
CREATE TYPE inbox_message_type AS ENUM (
    'LendingRequest', 'LendingAccepted', 'LendingDeclined',
    'ReturnRequest', 'ReturnConfirmed', 'ReturnReminder',
    'FriendRequest', 'FriendAccepted'
);

CREATE TABLE IF NOT EXISTS users (
    user_id       SERIAL PRIMARY KEY,
    username      VARCHAR(50)  UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS friends (
    friendship_id SERIAL PRIMARY KEY,
    user_id       INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    friend_id     INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    since         TIMESTAMP DEFAULT NOW(),
    UNIQUE (user_id, friend_id),
    CHECK (user_id <> friend_id)
);

CREATE TABLE IF NOT EXISTS books (
    book_id      SERIAL PRIMARY KEY,
    title        VARCHAR(255) NOT NULL,
    author       VARCHAR(255) NOT NULL,
    release_date DATE,
    language     VARCHAR(50),
    genre        VARCHAR(100),
    isbn_13      CHAR(13),
    isbn_10      CHAR(10)
);

CREATE TABLE IF NOT EXISTS book_collection (
    collection_id SERIAL PRIMARY KEY,
    user_id       INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    book_id       INT NOT NULL REFERENCES books(book_id) ON DELETE CASCADE,
    added_at      TIMESTAMP DEFAULT NOW(),
    condition     VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS lendings (
    lending_id        SERIAL PRIMARY KEY,
    borrowing_user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    book_id           INT NOT NULL REFERENCES books(book_id) ON DELETE CASCADE,
    reservation_date  TIMESTAMP,
    lent_date         TIMESTAMP,
    return_date       TIMESTAMP,
    status            lending_status NOT NULL DEFAULT 'Reserved'
);

CREATE TABLE IF NOT EXISTS inbox_messages (
    message_id   SERIAL PRIMARY KEY,
    recipient_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    type         inbox_message_type NOT NULL,
    content      TEXT NOT NULL,
    sent_at      TIMESTAMP DEFAULT NOW(),
    read         BOOLEAN DEFAULT FALSE
);
