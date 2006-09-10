------------------
--  Escolaridad --
------------------
CREATE TABLE degrees ( 
	id SERIAL NOT NULL,           
    	name text NOT NULL,
    	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE degrees IS
	'Lista de grados académicos:  Técnico, licenciatura, maestría, doctorado...';

CREATE TABLE careers (
	id SERIAL,
        name text NOT NULL,
        abbrev text NULL,
        moduser_id int4 NULL    -- Use it only to know who has
            REFERENCES users(id)    -- inserted, updated or deleted  
            ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
    	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY(id),
	UNIQUE (name)
);
COMMENT ON TABLE careers IS
	'Listado de carreras';

CREATE TABLE institutioncareers (
	id SERIAL,
	institution_id int4 NOT NULL 
            	REFERENCES institutions(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	degree_id int4 NOT NULL 
            	REFERENCES degrees(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	career_id int4 NOT NULL 
            	REFERENCES careers(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
        url  text NULL,
        other text NULL,
        moduser_id int4 NULL    -- Use it only to know who has
            REFERENCES users(id)    -- inserted, updated or deleted  
            ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
    	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY(id),
	UNIQUE (institution_id, career_id)
);
COMMENT ON TABLE institutioncareers IS
	'Carreras ligadas a las instituciónes';


CREATE TABLE credentials (
	id SERIAL,
	name text NULL,
	abbrev text NULL,
	moduser_id int4 NULL    -- Use it only to know who has
        	   REFERENCES users(id)    -- inserted, updated or deleted  
           	ON UPDATE CASCADE       -- data into or from this table.
            	DEFERRABLE,
    	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE credentials IS
	'Títulos o credenciales que obtiene una persona al titularse en determinado
	 grado académico: Lic., Mat., Fis., Arq., Dr., M. en C., etc.';

CREATE TABLE schoolings (
    id SERIAL,
    user_id int4 NOT NULL 
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    institutioncareer_id int4 NOT NULL 
            REFERENCES institutioncareers(id)       
            ON UPDATE CASCADE
            DEFERRABLE,
    credential_id int4 NOT NULL 
            REFERENCES credentials(id)       
            ON UPDATE CASCADE
            DEFERRABLE,
    startyear int4 NOT NULL,
    endyear   int4 NULL,
    studentid text NULL,
    credits int4 NULL
		CHECK (credits >= 0 AND credits <= 100),
    average int4 NULL,
--		CHECK (credits >= 1 AND credits <= 10),
    is_studying_this bool DEFAULT 'f' NOT NULL,
    is_titleholder bool DEFAULT 'f' NOT NULL,
    other text NULL,
    moduser_id int4 NULL    -- Use it only to know who has
           REFERENCES users(id)    -- inserted, updated or deleted  
            ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
    	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (user_id,  institutioncareer_id),
--    CONSTRAINT is_studying_or_is_finished_degree 
--	CHECK ( (is_studying_this = 't' AND is_titleholder = 'f'),
	--OR
	-- (is_studying_this = 'f' AND  endyear IS NOT NULL AND is_titleholder IS NOT NULL)), 
--	CONSTRAINT choose_credits_or_year CHECK 
--		(endyear IS NULL OR credits IS NULL OR credits = 100),
	CONSTRAINT valid_period CHECK (startyear < endyear)

);
COMMENT ON TABLE schoolings IS
	'Los diferentes grados en la historia académica de un usuario:
	* El nivel de estudios
	* Lugar y periodo correspondiente a cada uno de sus grados
	* Si esta estudiando el grado o ya lo termino?
	* Nos permite saber si esta titulado?
	* ..
';
COMMENT ON COLUMN schoolings.endyear IS
	'Año de egreso';
COMMENT ON COLUMN schoolings.studentid IS
	'Matrícula';
COMMENT ON COLUMN schoolings.is_titleholder IS
	'¿Es ya titulado? (endyear marca únicamente egreso)';
COMMENT ON COLUMN schoolings.credits IS
	'Porcentaje de créditos - No se reporta si ya egresó (endyear) ';
--  CONSTRAINT is_studying_or_is_finished_degre: Finished Degree (with or without proffessional title)    

CREATE TABLE titlemodalities( 
	id SERIAL NOT NULL,
	name char(30) NOT NULL,     
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE titlemodalities IS
	'Modalidad de titulación por medio de la cual alguien puede graduarse:
	Tesis, Ceneval, tesina, reporte técnico, por promedio...';


CREATE TABLE professionaltitles (
	id SERIAL,
        schooling_id integer NOT NULL 
             REFERENCES schoolings(id) 
             ON UPDATE CASCADE            
             DEFERRABLE,
        titlemodality_id integer NOT NULL
             REFERENCES titlemodalities(id)
             ON UPDATE CASCADE                 
             DEFERRABLE,
	professionalid text NULL,
    	year int4 NULL,
	thesistitle text NULL,
        moduser_id int4 NULL    -- Use it only to know who has
            REFERENCES users(id)    -- inserted, updated or deleted  
            ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
    	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE (schooling_id)
);
COMMENT ON TABLE professionaltitles IS
	'El usuario está ya titulado (de cada uno de los grados reportados en
	schooling)? Aquí van los datos de la titulación';
COMMENT ON COLUMN professionaltitles.professionalid IS
	'Cédula profesional';
COMMENT ON COLUMN professionaltitles.year IS
	'Año de titulación';
