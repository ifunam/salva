------------------
-- Languages    --
------------------

CREATE TABLE languages (
	id serial,
	name text NOT NULL,
	moduser_id int4 NULL  -- Use it only to know who has
             REFERENCES users(id) -- inserted, update or delete  
               ON UPDATE CASCADE  -- data into or from this table.
               DEFERRABLE,
	PRIMARY KEY(id), 
	UNIQUE (name)
);
COMMENT ON TABLE languages IS
	'Idiomas';
-- Español, inglés, francés, nahuatl, ztzotzil, etc

CREATE TABLE userlanguages (
	id serial,
	uid int4 NOT NULL  
        	REFERENCES users(id)
            	ON UPDATE CASCADE
	        ON DELETE CASCADE       
		DEFERRABLE,
	languages_id int4 NOT NULL  
        	REFERENCES languages(id)
            	ON UPDATE CASCADE
		DEFERRABLE,
	spokenpercentage int4 NULL, -- 100%
	writtenpercentaje int4 NULL, -- 100%
	comment text NULL,
	PRIMARY KEY(id)
);
COMMENT ON TABLE userlanguages IS
	'Relación de usuarios con lenguajes, indicando nivel de manejo';
COMMENT ON COLUMN userlanguages.comment IS
	'P.ej. indicando el curso o la institución donde lo aprendió';
