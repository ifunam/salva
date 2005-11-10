CREATE TABLE institutiontype (
	id SERIAL,
	name text NOT NULL,  
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE institutiontype IS
	'Tipos de institución';
-- Pública, privada, ONG, otra

CREATE TABLE institutiontitles (
	id SERIAL,
	name text NOT NULL,  
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE institutiontitles IS
	'Título (tipo, primer elemento del nombre) de una institución';
-- Escuela, Facultad, Instituto, Departamento, Unidad, Secretaría, Centro...

CREATE TABLE institutions (  
        id SERIAL,
        name text NOT NULL,
        url  text NULL,
        abbrev text NULL,
        state int4 NULL
		REFERENCES states(id)
		ON UPDATE CASCADE
		DEFERRABLE,
        other text NULL,
	parent_id integer NULL
            	REFERENCES institutions(id) 
            	ON UPDATE CASCADE           
            	ON DELETE CASCADE           
            	DEFERRABLE,
	country_id int4 NOT NULL 
            	REFERENCES countries(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	institutiontype_id int4 NOT NULL
            	REFERENCES institutiontype(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	institutiontitle_id int4 NOT NULL
            	REFERENCES institutiontitles(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	administrative_id text NULL,
        moduser_id int4 NULL    -- Use it only to know who has
            REFERENCES users(id)    -- inserted, updated or deleted  
            ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
        PRIMARY KEY(id),
	UNIQUE(name, country_id, state) 
); 
COMMENT ON TABLE institutions IS
	'Instituciones';
COMMENT ON COLUMN institutions.parent_id IS
	'Institución padre, para expresar jerarquías (p.ej. UNAM es la 
	institución padre de IIEc)';
COMMENT ON COLUMN institutions.administrative_id IS
	'Si la institución tiene alguna clave en su institución padre, la 
	indicamos aquí. Lo guardamos sólo como texto, no buscamos la integridad
	referencial';

CREATE TABLE goals (
        id SERIAL,
        name text NOT NULL, 
	moduser_id int4 NULL    -- Use it only to know who has
            REFERENCES users(id)    -- inserted, updated or deleted  
            ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
        PRIMARY KEY(id),
	UNIQUE(name) 
);
COMMENT ON TABLE goals IS
	'Una institución existe para cumplir ciertas metas - ¿cuáles? (tan
	genérico como sea posible)';
-- Educación, investigación, producción de blah, ...

CREATE TABLE institutionsgoals (
	id SERIAL,
	institution_id int4 NOT NULL 
            	REFERENCES institutions(id) 
            	ON UPDATE CASCADE           
            	ON DELETE CASCADE           
            	DEFERRABLE,
	goal_id int4 NOT NULL 
            	REFERENCES goals(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
        moduser_id int4 NULL    -- Use it only to know who has
            REFERENCES users(id)    -- inserted, updated or deleted  
            ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
        PRIMARY KEY(id),
	UNIQUE (institution_id, goal_id)
);
COMMENT ON TABLE institutionsgoals IS
	'Relación entre cada una de las instituciones y las metas';

