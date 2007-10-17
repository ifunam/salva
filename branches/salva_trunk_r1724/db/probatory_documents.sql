CREATE TABLE probatorydoctypes (
        id serial,
        name text NOT NULL,
        descr text NULL,
        moduser_id int4  NULL        -- Use it only to know who has
                REFERENCES users(id) -- inserted, updated or deleted
                ON UPDATE CASCADE    -- data into or from this table.
              DEFERRABLE,
        created_on timestamp DEFAULT CURRENT_TIMESTAMP,
        updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (id),
        UNIQUE (name)
);
COMMENT ON TABLE documenttypes IS
        'Tipos de documentos que se van cargar al sistema: Historial académico, Comprobante de Domicilio, Identificación oficial, etc';

CREATE TABLE probatory_documents (
       id serial,
       user_id int4 NOT NULL
               REFERENCES users(id)
               ON UPDATE CASCADE
               ON DELETE CASCADE
               DEFERRABLE,
       probatorydoctype_id int4 NOT NULL
                REFERENCES probatorydoctypes(id)
                ON UPDATE CASCADE
                DEFERRABLE,
       filename text NOT NULL,
       content_type text NOT NULL,
       file bytea NOT NULL,
       other text NULL,
       moduser_id int4  NULL            -- Use it only to know who has
       REFERENCES users(id)             -- inserted, updated or deleted
       ON UPDATE CASCADE                -- data into or from this table.
              DEFERRABLE,
       created_on timestamp DEFAULT CURRENT_TIMESTAMP,
       updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
       PRIMARY KEY (id),
       UNIQUE (user_id, probatorydoctype_id)
);

