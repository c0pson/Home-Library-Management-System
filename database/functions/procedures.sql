-- Returns all collection entries whose books are not currently Reserved or Lent.
CREATE OR REPLACE FUNCTION get_available_for_lending()
RETURNS TABLE(
    collection_id INT,
    book_id       INT,
    title         VARCHAR,
    author        VARCHAR,
    owner_id      INT,
    owner_username VARCHAR,
    condition     VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT bc.collection_id, b.book_id, b.title, b.author,
           u.user_id, u.username, bc.condition
    FROM book_collection bc
    JOIN books b ON bc.book_id = b.book_id
    JOIN users u ON bc.user_id = u.user_id
    WHERE bc.book_id NOT IN (
        SELECT book_id FROM lendings WHERE status IN ('Reserved', 'Lent')
    );
END;
$$ LANGUAGE plpgsql;

-- Marks lendings as Overdue when lent for more than 30 days without a return.
CREATE OR REPLACE FUNCTION mark_overdue_lendings()
RETURNS INT AS $$
DECLARE
    updated INT;
BEGIN
    UPDATE lendings
    SET status = 'Overdue'
    WHERE status = 'Lent'
      AND lent_date < NOW() - INTERVAL '30 days';
    GET DIAGNOSTICS updated = ROW_COUNT;
    RETURN updated;
END;
$$ LANGUAGE plpgsql;
