CREATE TABLE instadvicetarget (
	id SERIAL,
	name text NOT NULL,
        moduser_id int4 NULL    	     -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE instadvicetarget IS 
	'Destino de asesoría institucional';
-- Proyecto de investigación, planes/programas de estudio, materiales 
-- didácticos, evaluación, ...

CREATE TABLE indivadvicetarget (
	id SERIAL,
	name text NOT NULL,
        moduser_id int4 NULL    	     -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE indivadvicetarget IS
	'Tipo de persona que recibió asesoría individual';
-- Profesor, estudiante de servicio social, estudiante becario, estudiante
-- de bachillerato, estudiante de licenciatura, estudiante de maestría,
-- estudiante de doctorado

CREATE TABLE indivadviceprogram (
	id SERIAL,
	name text NOT NULL,
        moduser_id int4 NULL    	     -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE indivadviceprogram IS
	'Tipo de programa a que pertenece la persona que recibió asesoría';
-- PAAS, PIDI, PITID, Fundación UNAM, PAPIIT, DGAPA, DGEP, CONACyT

CREATE TABLE adviceactivity (
	id SERIAL,
	name text NOT NULL,
        moduser_id int4 NULL    	     -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE adviceactivity IS 
	'Actividades de la que constó una asesoría';
-- Diseño, evaluación, reestructuración, elaboración, ...

CREATE TABLE instadvice (
	id SERIAL,
	title text NOT NULL,
	acadprogram text NULL, -- Carreer or academic program
	user_id int4 NOT NULL 
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
	institution_id int4 NOT NULL
            REFERENCES institutions(id)
            ON UPDATE CASCADE
            DEFERRABLE,
	instadvicetarget_id int4 NOT NULL 
            REFERENCES instadvicetarget(id)      
            ON UPDATE CASCADE
            DEFERRABLE,
	academicdegrees_id int4 NULL       -- Defined in schoolinghistory
            REFERENCES academicdegrees(id)
            ON UPDATE CASCADE
            DEFERRABLE,
	other text NULL,
	year int4 NOT NULL,
	month int4 NULL CHECK (month >= 1 AND month <= 12),
	PRIMARY KEY (id)
);
COMMENT ON TABLE instadvice IS 
	'Asesoría prestada por un académico a una institución';

-- What activities were performed in a specific advice?
CREATE TABLE instadviceactivity (
	id SERIAL,
	instadvice_id int4 NOT NULL
            REFERENCES instadvice(id)
            ON UPDATE CASCADE
            DEFERRABLE,
	adviceactivity_id int4 NOT NULL
            REFERENCES adviceactivity(id)
            ON UPDATE CASCADE
            DEFERRABLE,
	duration text NULL, -- It can range wildly - any value is OK :-/ 
	PRIMARY KEY (id),
	UNIQUE (instadvice_id, adviceactivity_id)
);
COMMENT ON TABLE instadviceactivity IS 
	'Las actividades de las que constó una asesoría institucional';

-- Advice given to an individual
CREATE TABLE indivadvice (
	id SERIAL,
	user_is_internal bool, -- Is the user a full system user?
	user_id int4 NOT NULL 
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
	externaluser_id integer NULL 
            REFERENCES externalusers(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
	internaluser_id integer NULL
            REFERENCES users(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
	institution_id int4 NULL
            REFERENCES institutions(id)
            ON UPDATE CASCADE
            DEFERRABLE,
	indivadvicetarget_id int4 NOT NULL 
            REFERENCES instadvicetarget(id)      
            ON UPDATE CASCADE
            DEFERRABLE,
	indivadviceprogram_id int4 NULL 
            REFERENCES indivadviceprogram(id)      
            ON UPDATE CASCADE
            DEFERRABLE,
	academicdegrees_id int4 NULL       -- Defined in schoolinghistory
            REFERENCES academicdegrees(id)
            ON UPDATE CASCADE
            DEFERRABLE,
	year int4 NOT NULL,
	month int4 NULL CHECK (month >= 1 AND month <= 12),
	hours int4 NOT NULL,
	other text NULL,
	PRIMARY KEY (id),
	-- Sanity checks: If the user is a full system user, require the user
	-- to be filled in. Likewise for an external one.
	CHECK (user_is_internal = 't' OR
		(internaluser_id IS NOT NULL AND externaluser_id IS NULL)),
	CHECK (user_is_internal = 'f' OR
		(externaluser_id IS NOT NULL AND internaluser_id IS NULL))
);
COMMENT ON TABLE indivadvice IS 
	'Asesoría prestada por un académico a un individuo';
