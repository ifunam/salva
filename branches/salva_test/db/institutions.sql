CREATE TABLE institutiontypes (
        id SERIAL,
        name text NOT NULL,
        PRIMARY KEY (id),
        UNIQUE (name)
);
COMMENT ON TABLE institutiontypes IS
        'Tipo de institución:
        Pública, privada, ONG, otra';

CREATE TABLE institutiontitles (
        id SERIAL,
        name text NOT NULL,
        PRIMARY KEY (id),
        UNIQUE (name)
);
COMMENT ON TABLE institutiontitles IS
        'Título (tipo, primer elemento del nombre) de una institución:
         Universidad, Escuela, Facultad, Instituto, Departamento, Unidad, Secretaría, Centro...';

CREATE TABLE institutions (
        id SERIAL,
        institutiontype_id int4 NOT NULL
                REFERENCES institutiontypes(id)
                ON UPDATE CASCADE
                DEFERRABLE,
        name text NOT NULL,
        url  text NULL,
        abbrev text NULL,
        institution_id integer NULL
                REFERENCES institutions(id)
                ON UPDATE CASCADE
                ON DELETE CASCADE
                DEFERRABLE,
        institutiontitle_id int4 NOT NULL
                REFERENCES institutiontitles(id)
                ON UPDATE CASCADE
                ON DELETE CASCADE
                DEFERRABLE,
        addr text NULL,
        country_id int4 NOT NULL
                REFERENCES countries(id)
                ON UPDATE CASCADE
                ON DELETE CASCADE
                DEFERRABLE,
        state_id int4 NULL
                REFERENCES states(id)
                ON UPDATE CASCADE
                ON DELETE CASCADE
                DEFERRABLE,
        city_id int4 NULL
                REFERENCES cities(id)
                ON UPDATE CASCADE
                ON DELETE CASCADE
                DEFERRABLE,
        zipcode text NULL,
        phone text NULL,
        fax text NULL,
        administrative_key text NULL,
        other text NULL,
        moduser_id int4 NULL    -- Use it only to know who has
            REFERENCES users(id)    -- inserted, updated or deleted
            ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
        created_on timestamp DEFAULT CURRENT_TIMESTAMP,
        updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY(id),
        UNIQUE(name, country_id, state_id)
);
COMMENT ON TABLE institutions IS
        'Instituciones';
COMMENT ON COLUMN institutions.institution_id IS
        'Institución padre, para expresar jerarquías (p.ej. UNAM es la
        institución padre de IIEc)';
COMMENT ON COLUMN institutions.administrative_key IS
        'Si la institución tiene alguna clave en su institución padre, la
        indicamos aquí. Lo guardamos sólo como texto, no buscamos la integridad
        referencial';

CREATE TABLE sectors (
        id SERIAL,
        name text NOT NULL,
        moduser_id int4 NULL    -- Use it only to know who has
            REFERENCES users(id)    -- inserted, updated or deleted
            ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
        PRIMARY KEY(id),
        UNIQUE(name)
);
COMMENT ON TABLE sectors IS
        'Una institución pertences a cierto sectores - ¿cuáles? (tan
        genérico como sea posible:
        Educación, investigación, salud, energéticos, etc.';

CREATE TABLE institution_sectors (
        id SERIAL,
        institution_id int4 NOT NULL
                REFERENCES institutions(id)
                ON UPDATE CASCADE
                ON DELETE CASCADE
                DEFERRABLE,
        sector_id int4 NOT NULL
                REFERENCES sectors(id)
                ON UPDATE CASCADE
                DEFERRABLE,
        moduser_id int4 NULL    -- Use it only to know who has
            REFERENCES users(id)    -- inserted, updated or deleted
            ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
        PRIMARY KEY(id),
        UNIQUE (institution_id, sector_id)
);
COMMENT ON TABLE institution_sectors IS
        'Relación entre cada una de las instituciones y los sectores a los que pertenece';

