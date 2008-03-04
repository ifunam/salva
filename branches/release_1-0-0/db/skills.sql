CREATE TABLE skilltypes (
	id serial,
	name text NOT NULL,
	moduser_id integer NULL  -- It will be used only to know who has
        	REFERENCES users(id) -- inserted, updated or deleted  
            	ON UPDATE CASCADE    -- data into or from this table.
            	DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE skilltypes IS
	'Diferentes habilidades que un usuario (Tec. Acad.) puede reportar:
	 Habilidades relacionadas con la computación
	 Habilidades relacionadas con máquinas de oficina
	 Otras habilidades';

CREATE TABLE user_skills (
	id serial,
	user_id integer NOT NULL  
        	REFERENCES users(id) 
            	ON UPDATE CASCADE    
          	ON DELETE CASCADE     
            	DEFERRABLE,
	skilltype_id integer NOT NULL  
        	REFERENCES skilltypes(id) 
            	ON UPDATE CASCADE  
            	DEFERRABLE,
	descr text NULL,
	moduser_id integer NULL  -- It will be used only to know who has
        	REFERENCES users(id) -- inserted, updated or deleted  
            	ON UPDATE CASCADE    -- data into or from this table.
            	DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id)
);
COMMENT ON TABLE user_skills IS
	'Las habilidades que cada usuario tiene, junto con una descripción
	opcional';

