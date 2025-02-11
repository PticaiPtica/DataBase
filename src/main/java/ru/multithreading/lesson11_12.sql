SELECT id, name, price, publisher_id, number_pages, data_public, amount
FROM public.book;

--1.	Добавить в таблицу книг столбец «кол-во страниц»
--2.	С помощью подзапроса в условии найти все книги,
-- количество страниц в которых больше среднего.

SELECT id, name, price, publisher_id, number_pages
FROM public.book
WHERE number_pages > (SELECT AVG(number_pages) FROM book);

ALTER TABLE IF EXISTS public.book
    ADD COLUMN data_public date;

ALTER TABLE IF EXISTS public.book
    ADD COLUMN amount bigint;

--4.	С помощью подзапроса найти самые свежие книги
-- (подзапрос определяет MAX год, этот год используется в условии,
-- как было на занятии с максимальной ценой).
SELECT id, name, price, publisher_id, number_pages, data_public
FROM public.book
WHERE data_public = (SELECT MAX(data_public) FROM book);
--Лучше всего написать его с помощью подзапроса,
-- с помощью HAVING и с помощью CTE – одна и та же логика в трех реализациях
-- , лучше поймете.
SELECT *
FROM (SELECT name, SUM(amount * price) AS total
      FROM public.book
      GROUP BY name)
WHERE total > 700;

SELECT name, SUM(amount * price) AS total
FROM public.book
GROUP BY name
HAVING SUM(amount * price) > 700;

WITH sum_amount_price AS (SELECT name, SUM(amount * price) AS total
                          FROM public.book
                          GROUP BY name)
SELECT name, total
FROM sum_amount_price
WHERE total > 1000;

--7.	Написать запрос, который будет выводить в одной колонке
-- Название книги, год, ФИО автора, а также с помощью case when
-- будет определять, насколько книга новая
-- (в when условия по году, значения на ваше усмотрение)
Select (book.name, book.data_public, author.name,
        CASE
            WHEN book.data_public > '20-02-01' THEN 'новая'
            ELSE 'Старая'
            END)
FROM book
         JOIN book_author ON book_author.book_id = book.id
         JOIN author ON book_author.author_id = author.id
