CREATE TABLE techproducttypes (
        id serial,
        name text NOT NULL,
        moduser_id int4  NULL                -- Use it only to know who has
          REFERENCES users(id)             -- inserted, updated or deleted
          ON UPDATE CASCADE                -- data into or from this table.
          DEFERRABLE,
        created_on timestamp DEFAULT CURRENT_TIMESTAMP,
        updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (id)
);
COMMENT ON TABLE techproducttypes IS
        'Tipos de producto técnico:
        Desarrollo de instrumentación, Implementación de técnicas nuevas,
        Desarrollo de nuevos dispositivos, Desarrollo de hardware, Desarrollo de
         software, Patentes, Productos electrónicos, Productos magnéticos,
         Audio, video, CD, Floppy, DVD, otro';

CREATE TABLE techproductstatuses (
        id SERIAL,
        name text NOT NULL,
        PRIMARY KEY (id),
        UNIQUE (name)
);
COMMENT ON TABLE techproductstatuses IS
        'Estado en que puede estar un producto técnico: En desarrollo, entregado, publicado, otro';

CREATE TABLE techproducts (
        id serial,
        title text NOT NULL,
        techproducttype_id int4  NOT NULL
                REFERENCES techproducttypes(id)
                ON UPDATE CASCADE
                DEFERRABLE,
        authors text NOT NULL,
        descr text NULL,
        institution_id int4  NULL
                REFERENCES institutions(id)
                ON UPDATE CASCADE
                DEFERRABLE,
        techproductstatus_id int4  NOT NULL
                REFERENCES techproductstatuses(id)
                ON UPDATE CASCADE
                DEFERRABLE,
        other text NULL,
        moduser_id integer NULL  -- It will be used only to know who has
                REFERENCES users(id) -- inserted, updated or deleted
                ON UPDATE CASCADE    -- data into or from this table.
                DEFERRABLE,
        created_on timestamp DEFAULT CURRENT_TIMESTAMP,
        updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (id)
);
COMMENT ON TABLE techproducts IS
        'Cada uno de los productos técnicos generados';
COMMENT ON COLUMN techproducts.institution_id IS
        'Institución en la que este producto fue creado (independiente de las
        instituciones de adscripción de cada uno de sus participantes)';

CREATE TABLE user_techproducts (
        id SERIAL,
        user_id integer NOT NULL
                REFERENCES users(id)
                ON UPDATE CASCADE
                DEFERRABLE,
        techproduct_id integer NOT NULL
                REFERENCES techproducts(id)
                ON UPDATE CASCADE
                DEFERRABLE,
        userrole_id integer NULL
                REFERENCES userroles(id)
                ON UPDATE CASCADE
                DEFERRABLE,
        year int NOT NULL,
        moduser_id int4  NULL                -- Use it only to know who has
          REFERENCES users(id)             -- inserted, updated or deleted
          ON UPDATE CASCADE                -- data into or from this table.
          DEFERRABLE,
        created_on timestamp DEFAULT CURRENT_TIMESTAMP,
        updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (id),
        UNIQUE (techproduct_id, user_id, userrole_id)
);
COMMENT ON TABLE user_techproducts IS
        'Productos técnicos en los que cada usuario ha estado involucrado';


