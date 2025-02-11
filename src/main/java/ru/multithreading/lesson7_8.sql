SELECT  author.name AS "Автор" , book_id,book.name ,book.price ,publisher.name
FROM public.author,book_author,book,publisher
WHERE book_author.author_id = author.id AND
    book_author.book_id = book.id AND
    publisher_id = book.publisher_id;

SELECT AVG (book.price) AS "средняя цена",
       MIN (book.price)  AS "минимальная цена",
       MAX (book.price)  AS "максимальная цена"
From book;

SELECT  author.name, COUNT (author.name) AS "количество книг"
FROM public.author,book_author
WHERE book_author.author_id = author.id
Group BY author.name;

SELECT author.name  , Count (book.name) ,AVG (book.price)
FROM public.author,book_author , book
WHERE book_author.author_id = author.id AND
    book_author.book_id = book.id
Group BY author.name ;

INSERT INTO author (name)
VALUES ('Автор_1 без книги'),
       ('Автор_2 без книги');


INSERT INTO book_author (book_id, author_id)
VALUES (NULL, 4),
       (NULL, 5);

SELECT COUNT(author.name)
From author,book_author
WHERE book_author.author_id = author.id
  AND book_author.book_id IS NULL;

SELECT author.name, book_id
From author,book_author
WHERE book_author.author_id = author.id
  AND book_author.book_id IS NULL;

