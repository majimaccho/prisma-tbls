-- 書籍のビュー
CREATE VIEW books_view AS
SELECT
    books.id AS id,
    books.title AS title,
    books.price AS price,
    books.publisher_id AS publisher_id,
    publishers.name AS publisher_name,
    authors.id AS author_id,
    authors.name AS author_name
FROM
    books
LEFT JOIN publishers ON books.publisher_id = publishers.id
LEFT JOIN author_books ON books.id = author_books.book_id
LEFT JOIN authors ON author_books.author_id = authors.id;


COMMENT ON VIEW books_view IS '書籍のビュー';
COMMENT ON COLUMN books_view.id IS '書籍ID';
COMMENT ON COLUMN books_view.title IS '書籍名';
COMMENT ON COLUMN books_view.price IS '価格';
COMMENT ON COLUMN books_view.publisher_id IS '出版社ID';
COMMENT ON COLUMN books_view.publisher_name IS '出版社名';
COMMENT ON COLUMN books_view.author_id IS '著者ID';
COMMENT ON COLUMN books_view.author_name IS '著者名';
