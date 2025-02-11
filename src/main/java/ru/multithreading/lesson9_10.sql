CREATE TABLE public.author
(
    id   bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name character varying(50) UNIQUE

);

CREATE TABLE public.publisher
(
    id             bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name           character varying(50) NOT NULL,
    "commercially" boolean DEFAULT true
);

CREATE TABLE public.book
(
    id           bigint GENERATED ALWAYS AS IDENTITY,
    name         character varying(50) NOT NULL,
    price        bigint,
    publisher_id bigint,
    CONSTRAINT book_pkey PRIMARY KEY (id),
    CONSTRAINT fk_book_publisher FOREIGN KEY (publisher_id)
        REFERENCES public.publisher (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION

);

CREATE TABLE public.book_author
(
    book_id   bigint,
    author_id bigint,
    CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES public.author (id) MATCH SIMPLE,
    CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES public.book (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL

);


CREATE TABLE public.category
(
    id        bigint GENERATED ALWAYS AS IDENTITY,
    name      text,
    parent_id integer,
    CONSTRAINT category_pkey PRIMARY KEY (id)
);
