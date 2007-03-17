CREATE TABLE coursedurations (
	id serial NOT NULL,
	name text NOT NULL,
	days int4 NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE coursedurations IS
	'Duración de los periodos en que se imparten los cursos';
COMMENT ON COLUMN coursedurations.name IS
	'Nombre del periodo (semanal, mensual, trimestral, semestral, anual)';
COMMENT ON COLUMN coursedurations.days IS
	'Número de días dentro de este periodo';
-- {semanal,5}, {mensual,30}, {trimestral,90}, {semestral,180}, {anual,365}...

CREATE TABLE coursegrouptypes ( 
	id SERIAL NOT NULL,
	name text NOT NULL,
    	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE coursegrouptypes IS
	'Tipo de agrupador de cursos (diplomado, certificación, etc.)';
-- Certification, diplomado, ...

CREATE TABLE coursegroups (
	id serial,
	name text NOT NULL,
    	coursegrouptype_id int4 NOT NULL 
                        REFERENCES coursegrouptypes(id)
                        ON UPDATE CASCADE
                        DEFERRABLE,
	startyear int4 NOT NULL,
   	startmonth int4 NULL CHECK (startmonth >= 1 AND startmonth <= 12),
	endyear int4  NULL,
	endmonth int4 NULL CHECK (endmonth >= 1 AND endmonth <= 12),
	totalhours int4 NULL,
	PRIMARY KEY (id),
	UNIQUE (name),
	CONSTRAINT valid_duration CHECK (endyear IS NULL OR
		  (startyear * 12 + coalesce(startmonth,0)) > (endyear * 12 + coalesce(endmonth,0)))
);
COMMENT ON TABLE coursegroups IS
	'Datos de un supercurso/agrupador de cursos';
COMMENT ON COLUMN coursegroups.totalhours IS
	'No tiene relación con coursedurations - Por ejemplo, un diplomado 
	puede durar 150 horas a lo largo de un mes, de un semestre, de años.';


-- Las horas del curso seran calculadas basandonos en la duracion
-- del curso (usercourses) y la horas por semana (las cuales no
-- seran guardadas en ningún campo, solo serviran como referencia
-- en la aplicación.
CREATE TABLE courses (  
	id SERIAL NOT NULL,
    	name text NOT NULL,
	country_id int4 NOT NULL 
              REFERENCES countries(id)
              ON UPDATE CASCADE
              DEFERRABLE,
	institution_id int4 NULL
		REFERENCES institutions(id)
		ON UPDATE CASCADE
		DEFERRABLE,
   	coursegroup_id int4 NULL 
                        REFERENCES coursegroups(id)
                        ON UPDATE CASCADE
                       DEFERRABLE,
    	courseduration_id int4 NOT NULL
              REFERENCES coursedurations(id)
              ON UPDATE CASCADE
              DEFERRABLE,
    	modality_id int4 NOT NULL 
            REFERENCES modalities(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    	startyear int4 NOT NULL,
    	startmonth int4 NULL CHECK (startmonth >= 1 AND startmonth <= 12),
    	endyear int4  NULL,
	endmonth int4 NULL CHECK (endmonth >= 1 AND endmonth <= 12),
    	hoursxweek int4 NULL,
    	location text NULL,
    	totalhours int4 NULL,
    	PRIMARY KEY(id),
    	UNIQUE (name, startyear, startmonth)
);
COMMENT ON TABLE courses IS
	'Cursos impartidos (de actualización o en un plan de estudios) y
	recibidos (de actualización - los de plan de estudios son historial
	académico - ver schooling)';
COMMENT ON COLUMN courses.totalhours IS
	'Las horas del curso serán calculadas basándonos en la duración
	del curso (usercourses) y la horas por semana (las cuales no
	serán guardadas en ningún campo, solo serviran como referencia
	en la aplicación.';

CREATE TABLE roleincourses (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY (id),
	UNIQUE(name)
);
COMMENT ON TABLE roleincourses IS
	'Rol del usaurio en el curso';
-- Instructor, asistente, autor; etc.


-- Ojo cuando el usuario especifica horas por semana: Sera nencesario
-- revisar que las horas esten en un rango aceptable correspondiente
-- a la duración.
CREATE TABLE user_courses (
    id SERIAL,
    user_id int4 NOT NULL 
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    course_id int4 NULL 
            REFERENCES courses(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    roleincourse_id int4 NOT NULL 
            REFERENCES roleincourses(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    other text NULL,
    PRIMARY KEY (id)
);
COMMENT ON TABLE user_courses IS
	'Cursos a los que está asociado un usuario';

CREATE TABLE academicprograms (
	id serial NOT NULL,
	institutioncareer_id int4 NOT NULL 
            REFERENCES institutioncareers(id)       
            ON UPDATE CASCADE
            DEFERRABLE,
	year int NOT NULL,
	isopenuniversity BOOLEAN NOT NULL default 'f', -- Escolarizado o Universidad Abierta
	moduser_id int4 NULL    -- Use it only to know who has
  	    REFERENCES users(id)    -- inserted, updated or deleted  
       	    ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
    	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	UNIQUE(institutioncareer_id, year),
	PRIMARY KEY (id)
);

CREATE TABLE regularcourses (  
	id SERIAL NOT NULL,
    	title text NOT NULL,
	academicprogram_id int4 NULL 
            REFERENCES academicprograms(id)       
            ON UPDATE CASCADE
            DEFERRABLE,
	semester int NOT NULL,
    	modality_id int4 NOT NULL 
            REFERENCES modalities(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   	hoursxweek int4 NULL, -- Total de horas a la semana
	administrative_key text NULL,
	other text NULL,
	moduser_id int4 NULL    -- Use it only to know who has
  	    REFERENCES users(id)    -- inserted, updated or deleted  
       	    ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
    	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    	PRIMARY KEY(id)
);
COMMENT ON TABLE regularcourses IS
	'Cursos regulares';

CREATE TABLE roleinregularcourses (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY (id),
	moduser_id int4 NULL    -- Use it only to know who has
  	    REFERENCES users(id)    -- inserted, updated or deleted  
       	    ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
    	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	UNIQUE(name)
);

CREATE TABLE periods (
	id serial PRIMARY KEY,
	title text NOT NULL UNIQUE,
	startdate date NOT NULL,
	enddate date NOT NULL,
	moduser_id int4 NULL    -- Use it only to know who has
        REFERENCES users(id)    -- inserted, updated or deleted  
        ON UPDATE CASCADE       -- data into or from this table.
        DEFERRABLE,
    	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	UNIQUE (title,startdate,enddate)
);

CREATE TABLE user_regularcourses (
    id SERIAL,
    user_id int4 NOT NULL 
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    regularcourse_id int4 NULL 
            REFERENCES regularcourses(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    roleinregularcourse_id int4 NOT NULL 
            REFERENCES roleinregularcourses(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    period_id int4 NULL   
   	    REFERENCES periods(id)
            ON UPDATE CASCADE     
	    ON DELETE CASCADE
            DEFERRABLE,
    hoursxweek int4 NULL, -- Horas por rol, ejemplo: 6 profesor y 4 ayudante
    moduser_id int4 NULL    -- Use it only to know who has
  	    REFERENCES users(id)    -- inserted, updated or deleted  
       	    ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (user_id, regularcourse_id, period_id, roleinregularcourse_id)
);


