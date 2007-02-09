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
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id), 
	UNIQUE (name)
);
COMMENT ON TABLE languages IS
	'Idiomas:  Español, inglés, francés, nahuatl, ztzotzil, etc';

CREATE TABLE languagelevels (
	id serial,
	name text NOT NULL,
	moduser_id int4 NULL  -- Use it only to know who has
             REFERENCES users(id) -- inserted, update or delete  
               ON UPDATE CASCADE  -- data into or from this table.
               DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id), 
	UNIQUE (name)
);
COMMENT ON TABLE languagelevels IS
	'Nivel de dominio del lenguaje: Básico, Medio, Avanzado';

CREATE TABLE user_languages (
	id serial,
	user_id int4 NOT NULL  
        	REFERENCES users(id)
            	ON UPDATE CASCADE
	        ON DELETE CASCADE       
		DEFERRABLE,
	language_id int4 NOT NULL  
        	REFERENCES languages(id)
            	ON UPDATE CASCADE
		DEFERRABLE,
	spoken_languagelevel_id int4 NOT NULL  
        	REFERENCES languagelevels(id)
            	ON UPDATE CASCADE
		DEFERRABLE,
	written_languagelevel_id int4 NOT NULL  
        	REFERENCES languagelevels(id)
            	ON UPDATE CASCADE
		DEFERRABLE,
	comment text NULL,
	PRIMARY KEY(id),
	UNIQUE (language_id, spoken_languagelevel_id, written_languagelevel_id)
);
COMMENT ON TABLE user_languages IS
	'Relación de usuarios con lenguajes, indicando nivel de manejo';
COMMENT ON COLUMN user_languages.comment IS
	'P.ej. indicando el curso o la institución donde lo aprendió';
