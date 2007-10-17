CREATE TABLE newspapers (
        id SERIAL,
        name text NOT NULL,
        url text NULL,
        country_id int4 NOT NULL
              REFERENCES countries(id)
              ON UPDATE CASCADE
              DEFERRABLE,
        moduser_id int4  NULL                -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
        created_on timestamp DEFAULT CURRENT_TIMESTAMP,
        updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (id),
        UNIQUE(name)
);
COMMENT ON TABLE newspapers IS
        'Periódicos';

CREATE TABLE newspaperarticles (
        id serial,
        title text NOT NULL,
        authors text NOT NULL,
        newspaper_id int4 NOT NULL
            REFERENCES newspapers(id)
            ON UPDATE CASCADE
            DEFERRABLE,
        newsdate date NOT NULL,
        pages text NULL,
        url text NULL,
        moduser_id int4  NULL                -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
        created_on timestamp DEFAULT CURRENT_TIMESTAMP,
        updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (id),
        UNIQUE (title, newspaper_id, newsdate)
);
COMMENT ON TABLE newspaperarticles IS
        'Artículos publicados en periódico';

CREATE TABLE user_newspaperarticles (
    id SERIAL,
    user_id int4 NOT NULL
            REFERENCES users(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    newspaperarticle_id int4 NOT NULL
            REFERENCES newspaperarticles(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    ismainauthor BOOLEAN NOT NULL default 't',
    other text NULL,
    moduser_id int4  NULL            -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, newspaperarticle_id)
);
COMMENT ON TABLE user_newspaperarticles IS
        'Autores de un artículo periodístico';
COMMENT ON COLUMN user_newspaperarticles.ismainauthor IS
        'Registramos únicamente si es el autor primario o no';

