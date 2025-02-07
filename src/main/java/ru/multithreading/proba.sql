CREATE TABLE IF NOT EXISTS author
(
    id          bigint NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name_author character varying(10),

    CONSTRAINT "Uniq_name_author" UNIQUE (name_author)
        INCLUDE (name_author)

);
INSERT INTO author(name_author)
VALUES ('author_1')
     , ('author_2')
     , ('author_3')
     , ('author_4');

SELECT name_author AS "Автор"
From author;

CREATE TABLE IF NOT EXISTS publisher
(
    id              BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    publishing_name VARCHAR(25),
    CONSTRAINT "Uniq_publishing_name" UNIQUE (publishing_name)
        INCLUDE (publishing_name)

);

INSERT INTO publisher(publishing_name)
VALUES ('publisher_1')
        ,
       ('publisher_2'),
       ('publisher_4');

SELECT publishing_name AS "издательства"
From publisher;

CREATE TABLE IF NOT EXISTS book
(
    book_id         bigint NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    book_name       VARCHAR(15),
    book_publishing VARCHAR(15),
    CONSTRAINT "Uniq_book_name" UNIQUE (book_name)
        INCLUDE (book_name),
    CONSTRAINT fk_book_publishing FOREIGN KEY (book_publishing) REFERENCES publisher (publishing_name)

);

INSERT INTO book (book_name, book_publishing)
VALUES ('Book_1', 'publisher_1'),
       ('Book_2', 'publisher_2'),
       ('Book_3', 'publisher_3');

SELECT *
FROM book;

CREATE TABLE IF NOT EXISTS book_author
(
    name_book   character varying(15),
    name_author character varying(15),
    CONSTRAINT fk_book_name_author FOREIGN KEY (name_author) REFERENCES author (name_author),
    CONSTRAINT fk_book_name_ FOREIGN KEY (name_book) REFERENCES book (book_name)

);
INSERT INTO book_author(name_book, name_author)
VALUES ('Book_1', 'author_1'),
       ('Book_2', 'author_2');


SELECT *
FROM author;

SELECT *
FROM book;

SELECT *
FROM publisher;

SELECT *
FROM book_author
ORDER BY name_book;



SELECT book.book_name,
       book_author.name_author,
       publisher.publishing_name
FROM author,
     book,
     book_author,
     publisher
WHERE book.book_name = book_author.name_book
  AND book_author.name_author = author.name_author
  AND publisher.publishing_name = book.book_publishing

ORDER BY book_name;







