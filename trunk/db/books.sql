 -------------
--  Books  --
-------------

CREATE TABLE roleinbooks (
        id serial,
        name text NOT NULL,
        PRIMARY KEY (id),
        UNIQUE (name)
);
COMMENT ON TABLE roleinbooks IS
        'El rol que un usuario tiene en un libro:
         Autor, coautor, revisor, traductor, editor, compilador, coordinador';

CREATE TABLE booktypes (
        id SERIAL,
        name text NOT NULL,
        moduser_id int4  NULL                -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
        created_on timestamp DEFAULT CURRENT_TIMESTAMP,
        updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY(id),
        UNIQUE (name)
);
COMMENT ON TABLE booktypes IS
        'Tipo de libro:
         Único, serie, colección, libro arbitrado, etc.';

CREATE TABLE books (
    id SERIAL,
    title   text NOT NULL,
    author text NOT NULL,
    booklink text  NULL,
    country_id int4 NOT NULL
                 REFERENCES countries(id)
                 ON UPDATE CASCADE
                 DEFERRABLE,
    booktype_id int4 NOT NULL
            REFERENCES booktypes(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    volume_id int4 NULL
                REFERENCES volumes(id)
                ON UPDATE CASCADE
                DEFERRABLE,
    orig_language_id  int4 NULL
                REFERENCES languages(id)
                ON UPDATE CASCADE
                DEFERRABLE,
    trans_language_id int4 NULL
                REFERENCES languages(id)
                ON UPDATE CASCADE
                DEFERRABLE,
    moduser_id int4 NULL                    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
        created_on timestamp DEFAULT CURRENT_TIMESTAMP,
        updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
COMMENT ON TABLE books IS
        'Los libros que maneje el sistema';
COMMENT ON COLUMN books.author IS 'Nombre de los autores del libro
        (no es referencia, muchas veces no será usuario del sistema. Ver
        tabla userbooks)';

CREATE TABLE editions (
        id SERIAL,
        name text NOT NULL,
        moduser_id int4 NULL                        -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
        created_on timestamp DEFAULT CURRENT_TIMESTAMP,
        updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY(id),
        UNIQUE(name)
);
COMMENT ON TABLE editions IS
        'Ediciones (normalmente numeradas) de libros:
        Primera, segunda, tercera, especial, ...';

CREATE TABLE editionstatuses (
        id SERIAL,
        name text NOT NULL,
        PRIMARY KEY(id),
        UNIQUE(name)
);
COMMENT ON TABLE editionstatuses IS
        'Estado de una edición de un libro:
        Publicado, en prensa, aceptado para publicación, en dictámen/en evaluación';

CREATE TABLE bookeditions ( --
    id serial,
    book_id int4 NOT NULL
            REFERENCES books(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    edition_id int4 NOT NULL
            REFERENCES editions(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    pages int4 NULL,     -- Number of pages
    isbn  text NULL,     -- ISBN
    mediatype_id int4 NOT NULL
            REFERENCES mediatypes(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    editionstatus_id int4 NULL
            REFERENCES editionstatuses(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    month int4 NULL CHECK (month >= 1 AND month <= 12),
    year  int4 NOT NULL,       -- Edition year
    other text NULL,        -- Which URL / where can you find it / whatever
    moduser_id int4 NULL                    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (book_id, edition_id)
);
COMMENT ON TABLE bookeditions IS
        'Historial de las ediciones de un libro - En qué edición va? Cuándo
        fue impresa? Cuál es el estado de cada una de ellas?';

CREATE TABLE bookedition_publishers (
    id SERIAL,
    bookedition_id int4 NOT NULL
            REFERENCES bookeditions(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    publisher_id int4  NULL
            REFERENCES publishers(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    moduser_id int4 NULL                    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
     PRIMARY KEY (id),
    UNIQUE (bookedition_id, publisher_id)
);

CREATE TABLE bookedition_roleinbooks (
    id SERIAL,
    user_id int4 NOT NULL
            REFERENCES users(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    bookedition_id int4 NOT NULL
            REFERENCES bookeditions(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    roleinbook_id int4 NOT NULL
            REFERENCES roleinbooks(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    PRIMARY KEY(id),
    UNIQUE (user_id, bookedition_id, roleinbook_id)
);
COMMENT ON TABLE bookedition_roleinbooks IS
        'El rol de cada uno de los usuarios que participaron en un libro';


CREATE TABLE bookedition_comments (
    id SERIAL,
    user_id int4 NOT NULL
            REFERENCES users(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    bookedition_id int4 NOT NULL
            REFERENCES bookeditions(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    comment text NULL,        -- User comments for each edition
    moduser_id int4 NULL                    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    UNIQUE (user_id, bookedition_id)
);
COMMENT ON TABLE bookedition_comments IS
        'Comentarios adicionales del usuario para cada edicición';

CREATE TABLE bookchaptertypes (
        id SERIAL,
        name text NOT NULL,
        moduser_id int4 NULL                        -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
        created_on timestamp DEFAULT CURRENT_TIMESTAMP,
        updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY(id),
        UNIQUE(name)
);

CREATE table chapterinbooks (
   id SERIAL,
   bookedition_id int4 NOT NULL
           REFERENCES bookeditions(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   bookchaptertype_id int4 NOT NULL
           REFERENCES bookchaptertypes(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   title text NOT NULL,
   pages   text NULL,
   moduser_id int4 NULL                     -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
   created_on timestamp DEFAULT CURRENT_TIMESTAMP,
   updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (id),
   UNIQUE (bookedition_id, bookchaptertype_id, title)
);
CREATE INDEX chapterinbooks_title_idx ON chapterinbooks(title);
COMMENT ON TABLE chapterinbooks IS
        'Capítulos en un libro (cuando son reportados por separado)';
COMMENT ON COLUMN chapterinbooks.title IS
        'Título del capítulo';

CREATE TABLE roleinchapters (
        id serial,
        name text NOT NULL,
        PRIMARY KEY (id),
        UNIQUE (name)
);

CREATE TABLE chapterinbook_roleinchapters (
    id SERIAL,
    user_id int4 NOT NULL
            REFERENCES users(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    chapterinbook_id int4 NOT NULL
            REFERENCES chapterinbooks(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    roleinchapter_id int4 NOT NULL
            REFERENCES roleinchapters(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    moduser_id int4 NULL                    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (user_id, chapterinbook_id, roleinchapter_id)
);
COMMENT ON TABLE chapterinbook_roleinchapters IS
        'El rol de cada uno de los usuarios que participaron en un capítulo
         de libro';

CREATE TABLE chapterinbook_comments (
    id SERIAL,
    user_id int4 NOT NULL
            REFERENCES users(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    chapterinbook_id int4 NOT NULL
            REFERENCES chapterinbooks(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    comment text NULL,        -- User comments for each edition
    moduser_id int4 NULL                    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (user_id, chapterinbook_id)
);
COMMENT ON TABLE chapterinbook_comments IS
        'Comentarios adicionales del usuario para cada capítulo';
