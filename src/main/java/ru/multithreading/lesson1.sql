CREATE TABLE product
(
    id    BIGINT,
    name  VARCHAR(20),
    price BIGINT,
    type  TEXT
);
CREATE TABLE customer
(
    id   BIGINT,
    name VARCHAR(30),
    type TEXT
);
CREATE TABLE "order"
(
    Id       BIGINT,
    product  TEXT,
    customer TEXT,
    type     VARCHAR(10)
);
