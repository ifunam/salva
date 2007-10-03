----------------------
-- Other Activities --
----------------------
CREATE TABLE activitygroups (
        id serial,
        name text NOT NULL,
--         moduser_id int NULL                        -- Use it to known who
--             REFERENCES users(id)            -- has inserted, updated or deleted
--             ON UPDATE CASCADE               -- data into or  from this table.
--             DEFERRABLE,
        created_on timestamp DEFAULT CURRENT_TIMESTAMP,
        updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (id),
        UNIQUE (name)
);
COMMENT ON TABLE activitygroups IS
        'Listado del grupo al que pertenecen las otras actividades:
        Actividades de divulgación
        Actividades de extensión
        Actividades de difusión
        Servicios de apoyo
        Actividades de docencia
        Actividades de vinculación
        Otras actividades';

CREATE TABLE activitytypes (
        id serial,
        name text NOT NULL,
        activitygroup_id int4 NOT NULL
            REFERENCES activitygroups(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
        moduser_id int4 NULL                 -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
        created_on timestamp DEFAULT CURRENT_TIMESTAMP,
        updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (id),
        UNIQUE (name)
);
COMMENT ON TABLE activitytypes IS
        'Listado de otro tipo de actividades';


CREATE TABLE activities (
    id SERIAL,
    user_id int4 NOT NULL        -- Use it only to know who has
            REFERENCES users(id) -- inserted, updated or deleted
            ON UPDATE CASCADE    -- data into or from this table.
            DEFERRABLE,
    activitytype_id int4 NOT NULL
            REFERENCES activitytypes(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    name   text NOT NULL,
    descr   text NULL,
    year int4 NOT NULL,
    month int4 NULL CHECK (month >= 1 AND month <= 12),
    moduser_id int4 NULL                    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (activitytype_id, name, year, month)
);
COMMENT ON TABLE activities IS
        'Otras actividades académicas en las que participan los usuarios';
