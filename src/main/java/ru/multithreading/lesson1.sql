CREATE TABLE product
(
    id    BIGINT GENERATED ALWAYS AS IDENTITY,
    name  VARCHAR(10),
    price BIGINT,
    type  VARCHAR(10)
);


CREATE TABLE customer
(
    id   BIGINT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(10),
    type VARCHAR(10),
    city VARCHAR(15)
);
--a.	Вставить (INSERT INTO) в таблицу троих покупателей
-- (данные определите сами исходя из столбцов,
-- но так чтобы у нескольких покупателей был город Ленинград.

INSERT INTO customer (name, type, city)
VALUES ('ОЛЕГ', 'VIP', 'ЛЕНИНГРАД'),
       ('ВИКТОР', 'VIP', 'ЛЕНИНГРАД'),
       ('ГРИГОРИЙ', 'VIP', 'ЛЕНИНГРАД'),
       ('Кристина', 'VIP', 'МОСКВА'),
       ('ВИКА', 'VIP', 'МОСКВА'),
       ('КСЮША', 'VIP', 'МОСКВА');

--b.Изменить (UPDATE) фамилию (или фио)
-- любого покупателя по его id (WHERE)

UPDATE customer
SET name = 'НИКОЛАЙ'
WHERE id = '2';


--c.У всех покупателей с городом Ленинград (WHERE)
--изменить (UPDATE) его на Санкт-Петербург
UPDATE customer
set city = 'Санкт-Петербург'
WHERE city = 'ЛЕНИНГРАД';


--d.	Удалить (DELETE) одного покупателя по его id (WHERE)
DELETE
FROM customer
WHERE id = 3;
--e.	Получить (SELECT) всех покупателей из таблицы
SELECT Id,
       name AS "Имя Покупателя",
       type AS "Тип Покупателя",
       city AS "Город"
FROM customer
ORDER BY id DESC;

--f.	Получить (SELECT) покупателей с городом Санкт-Петербург (WHERE),
-- отсортированных по фамилии (фио) по алфавиту (ORDER BY)
SELECT Id,
       name AS "Имя Покупателя",
       type AS "Тип Покупателя",
       city AS "Город"
FROM customer
WHERE city = 'Санкт-Петербург'
ORDER BY name ;


CREATE TABLE "order"
(
    Id       BIGINT GENERATED ALWAYS AS IDENTITY,
    product  VARCHAR(10),
    customer VARCHAR(10),
    type     VARCHAR(10)
);
