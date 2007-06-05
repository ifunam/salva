CREATE TABLE instadvicetargets (
	id SERIAL,
	name text NOT NULL,
	moduser_id int4 NULL               	    -- Use it to known who
	REFERENCES users(id)            -- has inserted, updated or deleted
	ON UPDATE CASCADE               -- data into or  from this table.
	DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE instadvicetargets IS 
	'Destino de asesoría institucional';
-- Proyecto de investigación, planes/programas de estudio, materiales 
-- didácticos, evaluación, ...

CREATE TABLE indivadvicetargets (
	id SERIAL,
	name text NOT NULL, 
	moduser_id int4 NULL               	    -- Use it to known who
	REFERENCES users(id)            -- has inserted, updated or deleted
	ON UPDATE CASCADE               -- data into or  from this table.
	DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,              	    -- Use it to known who
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE indivadvicetargets IS
	'Tipo de persona que recibió asesoría individual';
-- Profesor, estudiante de servicio social, estudiante becario, estudiante
-- de bachillerato, estudiante de licenciatura, estudiante de maestría,
-- estudiante de doctorado

CREATE TABLE indivadviceprograms (
	id SERIAL,
	name text NOT NULL, 
	descr text NULL,
	institution_id int4 NOT NULL
            REFERENCES institutions(id)
            ON UPDATE CASCADE
            DEFERRABLE,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE indivadviceprograms IS
	'Tipo de programa a que pertenece la persona que recibió asesoría';
-- PAAS, PIDI, PITID, Fundación UNAM, PAPIIT, DGAPA, DGEP, CONACyT

CREATE TABLE adviceactivities (
	id SERIAL,
	name text NOT NULL, 
	moduser_id int4 NULL               	    -- Use it to known who
	REFERENCES users(id)            -- has inserted, updated or deleted
	ON UPDATE CASCADE               -- data into or  from this table.
	DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,              	
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE adviceactivities IS 
	'Actividades de la que constó una asesoría';
-- Diseño, evaluación, reestructuración, elaboración, ...

CREATE TABLE instadvices (
	id SERIAL,
	title text NOT NULL,
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
            REFERENCES instadvicetargets(id)      
            ON UPDATE CASCADE
            DEFERRABLE,
	other text NULL,
	year int4 NOT NULL,
	month int4 NULL CHECK (month >= 1 AND month <= 12),
	moduser_id int4 NULL               	    -- Use it to known who
	REFERENCES users(id)            -- has inserted, updated or deleted
	ON UPDATE CASCADE               -- data into or  from this table.
	DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id)
);
COMMENT ON TABLE instadvices IS 
	'Asesoría prestada por un académico a una institución';

-- What activities were performed in a specific advice?
CREATE TABLE instadviceactivities (
	id SERIAL,
	instadvice_id int4 NOT NULL
            REFERENCES instadvices(id)
            ON UPDATE CASCADE
            DEFERRABLE,
	adviceactivity_id int4 NOT NULL
            REFERENCES adviceactivities(id)
            ON UPDATE CASCADE
            DEFERRABLE,
	duration text NULL, -- It can range wildly - any value is OK :-/ 
	moduser_id int4 NULL               	    -- Use it to known who
	REFERENCES users(id)            -- has inserted, updated or deleted
	ON UPDATE CASCADE               -- data into or  from this table.
	DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE (instadvice_id, adviceactivity_id)
);
COMMENT ON TABLE instadviceactivities IS 
	'Las actividades de las que constó una asesoría institucional';

-- Advice given to an individual
CREATE TABLE indivadvices (
	id SERIAL,
	user_id int4 NOT NULL 
	    REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,	    
	indivname text NULL,
	indivuser_id integer NULL  -- use this if the indiv has user_id
            REFERENCES users(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
	institution_id int4 NULL
            REFERENCES institutions(id)
            ON UPDATE CASCADE
            DEFERRABLE,
	indivadvicetarget_id int4 NOT NULL 
            REFERENCES indivadvicetargets(id)      
            ON UPDATE CASCADE
            DEFERRABLE,
	indivadviceprogram_id int4 NULL 
            REFERENCES indivadviceprograms(id)      
            ON UPDATE CASCADE
            DEFERRABLE,
	degree_id int4 NULL       -- Defined in schoolinghistory
            REFERENCES degrees(id)
            ON UPDATE CASCADE
            DEFERRABLE,
	year int4 NOT NULL,
	month int4 NULL CHECK (month >= 1 AND month <= 12),
	hours int4 NOT NULL,
	other text NULL,
	moduser_id int4 NULL               	    -- Use it to known who
	REFERENCES users(id)            -- has inserted, updated or deleted
	ON UPDATE CASCADE               -- data into or  from this table.
	DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	-- Sanity checks: If the individual adviced is a full system user, 
	-- require the user to be filled in, otherwise use name. 
	CHECK (indivuser_id IS NOT NULL OR indivname IS NOT NULL)
);
COMMENT ON TABLE indivadvices IS 
	'Asesoría prestada por un académico a un individuo';
