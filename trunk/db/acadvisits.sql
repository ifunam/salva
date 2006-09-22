----------------------------------------
-- Estancias y sabaticos              --
----------------------------------------

CREATE TABLE acadvisittypes (
	id SERIAL,
	name text NOT NULL,
	moduser_id int4 NULL  -- Use it only to know who has
             REFERENCES users(id) -- inserted, update or delete  
               ON UPDATE CASCADE  -- data into or from this table.
               DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE acadvisittypes IS
	'Tipos de visita académica: 
	Sabático, posdoctoral, de investigación...';

CREATE TABLE acadvisits (
	id  SERIAL NOT NULL,
	user_id int4 NOT NULL
            REFERENCES users(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    	institution_id integer NOT NULL 
	    REFERENCES institutions(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
	country_id smallint NOT NULL
            REFERENCES countries(id)
            ON UPDATE CASCADE
            DEFERRABLE,
	acadvisittype_id integer NOT NULL 
	    REFERENCES acadvisittypes(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
        name text NOT NULL,
	startyear int4 NOT NULL,
	startmonth int4 NULL CHECK (startmonth >= 1 AND startmonth <= 12),
	endyear int4  NULL,
	endmonth int4 NULL CHECK (endmonth >= 1 AND endmonth <= 12),
	place text NULL,
	goals text NULL,
    	other text  NULL,
	externaluser_id integer NULL 
            REFERENCES externalusers(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
	moduser_id int4 NULL  -- Use it only to know who has
             REFERENCES users(id) -- inserted, update or delete  
               ON UPDATE CASCADE  -- data into or from this table.
               DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id),
	CONSTRAINT valid_duration CHECK (endyear IS NULL OR
	       (startyear * 12 + coalesce(startmonth,0)) > (endyear * 12 + coalesce(endmonth,0)))
);
COMMENT ON TABLE acadvisits IS
	'Cada una de las visitas académicas, relacionadas con el usuario en 
	cuestión';

COMMENT ON COLUMN acadvisits.externaluser_id IS
	'Si esta columna apunta a un usuario externo, significa que el usuario participo
	 en la coordinación de una visita o estancia académica de un invitado';

CREATE TABLE sponsor_acadvisits (
	id  SERIAL NOT NULL,
	acadvisit_id integer NOT NULL 
	    REFERENCES  acadvisits(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
 	institution_id integer NOT NULL 
	    REFERENCES institutions(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
	amount integer NOT NULL,
	moduser_id int4 NULL  -- Use it only to know who has
             REFERENCES users(id) -- inserted, update or delete  
               ON UPDATE CASCADE  -- data into or from this table.
               DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id)
);
COMMENT ON TABLE sponsor_acadvisits IS
	'Institución patrocinadora de cada visita académica';
