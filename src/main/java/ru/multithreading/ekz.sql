CREATE TYPE category_transport AS ENUM
    (
        'Econom' ,
        'Standart' ,
        'Vip'
        );

CREATE TABLE organization
(
    id   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) UNIQUE
);

CREATE TABLE transport
(
    id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name            VARCHAR(50),
    category        category_transport DEFAULT 'Standart',
    car_number      VARCHAR(6),
    organization_id BIGINT,
    CONSTRAINT fk_organization FOREIGN KEY (organization_id) REFERENCES organization (id)
);

CREATE TABLE drivers
(
    id                 BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name               VARCHAR(50) UNIQUE,
    driving_experience BIGINT
);

CREATE TABLE route
(
    id   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT,
    time TIME
);

CREATE TABLE transport_drivers
(
    transport_id BIGINT,
    drivers_id   BIGINT,

    CONSTRAINT fk_transport FOREIGN KEY (transport_id) REFERENCES transport (id),
    CONSTRAINT fk_drivers FOREIGN KEY (drivers_id) REFERENCES drivers (id)
);

CREATE TABLE transport_route
(
    transport_id BIGINT,
    route_id     BIGINT,

    CONSTRAINT fk_transport FOREIGN KEY (transport_id) REFERENCES transport (id),
    CONSTRAINT fk_route FOREIGN KEY (route_id) REFERENCES route (id)
);



INSERT INTO organization(name)
VALUES ('Доставщики'),
       ('Перевозчики'),
       ('Водители');


SELECT id, name
FROM organization;

INSERT INTO drivers(name, driving_experience)
VALUES ('Василий', 5),
       ('Алексей', 8),
       ('Григорий', 1),
       ('Олег', 3),
       ('Егор', 2),
       ('Антон', 6),
       ('Елена', 5),
       ('Глеб', 2),
       ('Вячеслав', 3);


SELECT id, name, driving_experience
FROM drivers;

INSERT INTO route(name, "time")
VALUES ('Маршрут_2', '01:30'),
       ('Маршрут_3', '03:10'),
       ('Маршрут_4', '02:20'),
       ('Маршрут_5', '00:30');

SELECT id, name, "time"
FROM route;


INSERT INTO transport(name, category, organization_id, car_number)
VALUES ('LADA', 'Econom', 1, 'В137АО'),
       ('HONDA', 'Standart', 1, 'М652АН'),
       ('FORD', 'Vip', 1, 'К372ОА'),

       ('LADA', 'Econom', 2, 'С356РВ'),
       ('HONDA', 'Standart', 2, 'С987КМ'),
       ('FORD', 'Vip', 2, 'К145ВТ'),

       ('VOLGA', 'Econom', 3, 'C770XT'),
       ('HONDA', 'Standart', 3, 'М652ТС'),
       ('FORD', 'Vip', 3, 'Е169КХ');

SELECT id, name, category, organization_id, car_number
FROM transport;



INSERT INTO transport_drivers(transport_id, drivers_id)
VALUES (1, 7),
       (2, 9),
       (3, 5),
       (4, 1),
       (5, 4),
       (6, 2),
       (7, 8),
       (8, 3),
       (9, 6)
;

SELECT transport_id, drivers_id
FROM transport_drivers;


INSERT INTO transport_route(transport_id, route_id)
VALUES (3, 1),
       (7, 1),
       (6, 2),
       (9, 3),
       (1, 3),
       (4, 4),
       (2, NULL),
       (5, NULL),
       (8, NULL),
       (NULL, 5);

SELECT transport_id, route_id
FROM transport_route;


CREATE VIEW transport_name AS
SELECT organization.name    AS "Организация",
       drivers.name         AS "ФИО",
       transport.name       AS "Автомобиль",
       transport.category   AS "Категория",
       transport.car_number AS "Номер Авто"
FROM transport
         JOIN organization ON transport.organization_id = organization.id
         JOIN transport_drivers ON transport_drivers.transport_id = transport.id
         JOIN drivers ON drivers.id = transport_drivers.drivers_id;

SELECT "Организация", "ФИО", "Автомобиль", "Категория", "Номер Авто"
FROM public.transport_name;


CREATE VIEW transport_name_route AS
SELECT organization.name    AS "Организация",
       drivers.name         AS "ФИО",
       transport.name       AS "Автомобиль",
       transport.category   AS "Категория",
       transport.car_number AS "Номер Авто",
       route.name           AS "Маршрут"
FROM transport
         JOIN organization ON transport.organization_id = organization.id
         JOIN transport_drivers ON transport_drivers.transport_id = transport.id
         JOIN drivers ON drivers.id = transport_drivers.drivers_id
         JOIN transport_route ON transport_route.transport_id = transport.id
         FULL JOIN route ON route.id = transport_route.route_id;

SELECT "Организация", "ФИО", "Автомобиль", "Категория", "Номер Авто", "Маршрут"
FROM public.transport_name_route;


SELECT transport_id,
       route_id,
       transport.name AS "Автомобиль"
FROM transport
         JOIN transport_route ON transport_route.transport_id = transport.id
WHERE transport_route.route_id IS NULL;



CREATE OR REPLACE FUNCTION get_count_transport_1(number_org BIGINT)
    RETURNS INT
AS
$$
BEGIN
    RETURN count(*) AS "count"
                 FROM transport
                          JOIN organization ON transport.organization_id = organization.id
                      WHERE transport.organization_id = number_org;

END;

$$
    LANGUAGE 'plpgsql';

SELECT get_count_transport_1(2);