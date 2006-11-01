------------------------------
-- Research lines and areas -- 
------------------------------

-- They are all a very simple catalog - the difference is merely semantic

------ (maybe they should be merged into a single table with a field signaling
------ this semantic difference? Other institutions might have different such
------ categories...)

CREATE TABLE researchareas (
    id SERIAL,
    name text NOT NULL,
    descr text NULL,
    moduser_id int4  NULL    	     -- Use it only to know who has
    REFERENCES users(id)             -- inserted, updated or deleted  
    ON UPDATE CASCADE                -- data into or from this table.
    DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (name)
);
COMMENT ON TABLE researchareas IS
	'Areas de investigación (ligadas desde projectresearchareas)';



CREATE TABLE researchlines (
    id SERIAL,
    name text NOT NULL,
    descr text NULL,
    researcharea_id int4  NULL 	     -- Use it only to know who has
    REFERENCES researchareas(id)     -- inserted, updated or deleted  
    ON UPDATE CASCADE                -- data into or from this table.
    DEFERRABLE,
    moduser_id int4  NULL    	     -- Use it only to know who has
    REFERENCES users(id)             -- inserted, updated or deleted  
    ON UPDATE CASCADE                -- data into or from this table.
              DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (name,researcharea_id)
);
COMMENT ON TABLE researchlines IS
	'Líneas de investigación';

CREATE TABLE user_researchlines (
    id SERIAL,
    user_id int4 NOT NULL
            REFERENCES users(id)     
            ON UPDATE CASCADE   
            ON DELETE CASCADE  
            DEFERRABLE,
    researchline_id int4 NOT NULL
            REFERENCES researchlines(id)     
            ON UPDATE CASCADE   
            DEFERRABLE,
    moduser_id int4  NULL    	     -- Use it only to know who has
    REFERENCES users(id)             -- inserted, updated or deleted  
    ON UPDATE CASCADE                -- data into or from this table.
    DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, researchline_id)
);
COMMENT ON TABLE user_researchlines IS
	'Líneas de investigación en que participa un usuario';


