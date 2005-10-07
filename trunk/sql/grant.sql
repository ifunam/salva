-------------
-- Grants  --
-------------

CREATE TABLE grants ( 
    id SERIAL,
    title text NOT NULL,
    institution_id int4 NOT NULL
            REFERENCES institutions(id) 
            ON UPDATE CASCADE           
            DEFERRABLE,
    moduser_id int4 NULL       -- Use it only to know who has
            REFERENCES users(id)   -- inserted, updated or deleted  
            ON UPDATE CASCADE      -- data into or from this table.
            DEFERRABLE,
    PRIMARY KEY (id),
    UNIQUE (title, institution_id)
);
COMMENT ON TABLE grants IS
	'Listado de becas, institución que las otorga';

CREATE TABLE usergrants (
    id serial,
    grants_id int4 NOT NULL 
            REFERENCES grants(id)      
            ON UPDATE CASCADE
            DEFERRABLE,
    uid int4 NOT NULL 
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    description text NULL, -- What is the purpose of this grant?
    startyear int4 NOT NULL,
    startmonth int4 NULL CHECK (startmonth >= 1 AND startmonth <= 12),
    endyear int4  NULL,
    endmonth int4 NULL CHECK (endmonth >= 1 AND endmonth <= 12),
    PRIMARY KEY (id),
    UNIQUE (grants_id, uid, startyear, startmonth),
    CONSTRAINT valid_duration CHECK (endyear IS NULL OR
	       (startyear * 12 + coalesce(startmonth,0)) > (endyear * 12 + coalesce(endmonth,0)))
);
COMMENT ON TABLE usergrants IS
	'Quién ha recibido qué becas';
COMMENT ON COLUMN usergrants.description IS
	'¿Existe un objetivo de esta beca? ¿Cuál es?';
