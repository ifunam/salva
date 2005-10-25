------------------------------
-- Research lines and areas -- 
------------------------------

-- They are all a very simple catalog - the difference is merely semantic

------ (maybe they should be merged into a single table with a field signaling
------ this semantic difference? Other institutions might have different such
------ categories...)

CREATE TABLE researchareas(
    id SERIAL,
    name text NOT NULL,
    description text NULL,
    moduser_id int4 NULL                 -- Use it only to know who has
            REFERENCES users(id)             -- inserted, update or delete  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
    PRIMARY KEY (id),
    UNIQUE (name)
);
COMMENT ON TABLE researchareas IS
	'Áreas de investigación (ligadas desde projectresearchareas)';

CREATE TABLE researchlines(
    id SERIAL,
    name text NOT NULL,
    description text NULL,
    moduser_id int4 NULL                 -- Use it only to know who has
            REFERENCES users(id)             -- inserted, update or delete  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
    PRIMARY KEY (id),
    UNIQUE (name)
);
COMMENT ON TABLE researchlines IS
	'Líneas de investigación';

CREATE TABLE userresearchlines(
    id SERIAL,
    user_id int4 NOT NULL
            REFERENCES users(id)     
            ON UPDATE CASCADE   
            ON DELETE CASCADE  
            DEFERRABLE,
    researchlines_id int4 NOT NULL
            REFERENCES researchlines(id)     
            ON UPDATE CASCADE   
            DEFERRABLE,
    PRIMARY KEY (user_id, researchlines_id)
);
COMMENT ON TABLE userresearchlines IS
	'Líneas de investigación en que participa un usuario';
