CREATE TABLE documenttypes (
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
        'Tipos de documentos que se van expedir: Informe anual, plan anual, curriculum, etc';

CREATE TABLE documents (
        id serial,
        documenttype_id int4 NOT NULL
                REFERENCES documenttypes(id)
                ON UPDATE CASCADE
                DEFERRABLE,
        title text NOT NULL,
        startdate date NOT NULL,
        enddate date NOT NULL,
        moduser_id int4  NULL        -- Use it only to know who has
                REFERENCES users(id) -- inserted, updated or deleted
                ON UPDATE CASCADE    -- data into or from this table.
              DEFERRABLE,
        created_on timestamp DEFAULT CURRENT_TIMESTAMP,
        updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY(id),
        UNIQUE (documenttype_id, title)
);
COMMENT ON TABLE documents IS
        'Esta tabla indica el tipo de documento que se va a almacenar y el período válido para su expedición';

CREATE TABLE user_documents (
        id serial,
        user_id int4 NOT NULL
                REFERENCES users(id)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
        document_id int4 NOT NULL
                REFERENCES documents(id)
                ON UPDATE CASCADE
                DEFERRABLE,
        user_incharge_id int4  NULL
                REFERENCES users(id)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
        status boolean NOT NULL default 'f', -- True = Approved OR False = Pending
        file  bytea NOT NULL,
        filename text NOT NULL,
        content_type text NOT NULL,
        ip_address text NOT NULL, -- Inet data type is unssupported in rails
        moduser_id int4  NULL        -- Use it only to know who has
               REFERENCES users(id) -- inserted, updated or deleted
               ON UPDATE CASCADE    -- data into or from this table.
               DEFERRABLE,
        created_on timestamp DEFAULT CURRENT_TIMESTAMP,
        updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (id),
        UNIQUE (user_id, document_id)
);
COMMENT ON TABLE user_documents IS
        'Documentos que ha publicado el usuario';

CREATE TABLE user_document_logs (
       id serial,
        user_document_id int4 NOT NULL,
        user_id int4 NOT NULL,
        prev_ip_address text NOT NULL,
        prev_status boolean NOT NULL,
        PRIMARY KEY (id)
);
COMMENT ON TABLE user_document_logs IS
        'En esta tabla se registra el cambio en los estados de los documentos, usualmente hechos por los jefes de departamento o responsables del personal';

