----------------------
-- Research Courses -- 
----------------------

CREATE TABLE coursetype ( 
	id SERIAL NOT NULL,
	name text NOT NULL,
    	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE coursetype IS
	'Tipo de curso en cuesstión - Regular, especial, ...';
-- Regular (parte  de un plan de estudios), Especial (único), ...

CREATE TABLE coursesduration (
	id serial NOT NULL,
	name text NOT NULL,
	days int4 NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE coursesduration IS
	'Duración de los periodos en que se imparten los cursos';
COMMENT ON COLUMN coursesduration.name IS
	'Nombre del periodo (semanal, mensual, trimestral, semestral, anual)';
COMMENT ON COLUMN coursesduration.days IS
	'Número de días dentro de este periodo';
-- {semanal,5}, {mensual,30}, {trimestral,90}, {semestral,180}, {anual,365}...

CREATE TABLE coursegrouptype ( 
	id SERIAL NOT NULL,
	name text NOT NULL,
    	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE coursegrouptype IS
	'Tipo de agrupador de cursos (diplomado, certificación, etc.)';
-- Certification, diplomado, ...

CREATE TABLE coursegroup (
	id serial,
	name text,
    	coursegrouptype_id int4 NOT NULL 
                        REFERENCES coursegrouptype(id)
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
COMMENT ON TABLE coursegroup IS
	'Datos de un supercurso/agrupador de cursos';
COMMENT ON COLUMN coursegroup.totalhours IS
	'No tiene relación con coursesduration - Por ejemplo, un diplomado 
	puede durar 150 horas a lo largo de un mes, de un semestre, de años.';

-- Las horas del curso seran calculadas basandonos en la duracion
-- del curso (usercourses) y la horas por semana (las cuales no
-- seran guardadas en ningún campo, solo serviran como referencia
-- en la aplicación.
CREATE TABLE courses (
    id SERIAL NOT NULL,
    title text NOT NULL,
    coursetype_id int4 NOT NULL 
                        REFERENCES coursetype(id)
                        ON UPDATE CASCADE
                        DEFERRABLE,
    academicdegrees_id int4 NULL 
                           REFERENCES academicdegrees(id)
                           ON UPDATE CASCADE
                           DEFERRABLE,
    hours int4 NULL,
    PRIMARY KEY(id),
    UNIQUE (title,  coursetype_id, academicdegrees_id )
);
COMMENT ON TABLE courses IS
	'Cursos impartidos (de actualización o en un plan de estudios) y
	recibidos (de actualización - los de plan de estudios son historial
	académico - ver schooling)';
COMMENT ON COLUMN courses.hours IS
	'Las horas del curso serán calculadas basándonos en la duración
	del curso (usercourses) y la horas por semana (las cuales no
	serán guardadas en ningún campo, solo serviran como referencia
	en la aplicación.';

CREATE TABLE roleincourse (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY (id),
	UNIQUE(name)
);
COMMENT ON TABLE roleincourse IS
	'Rol del usaurio en el curso';
-- Instructor, asistente, autor; etc.

-- Ojo cuando el usuario especifica horas por semana: Sera nencesario
-- revisar que las horas esten en un rango aceptable correspondiente
-- a la duración.
CREATE TABLE usercourses (
    id SERIAL,
    user_id int4 NOT NULL 
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    courses_id int4 NULL 
            REFERENCES courses(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    coursegroup_id int4 NULL 
            REFERENCES coursegroup(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    roleincourse_id int4 NOT NULL 
            REFERENCES roleincourse(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    institution_id int4 NULL
		REFERENCES institutions(id)
		ON UPDATE CASCADE
		DEFERRABLE,
    country_id int4 NOT NULL 
              REFERENCES countries(id)
              ON UPDATE CASCADE
              DEFERRABLE,
    coursesduration_id int4 NOT NULL
              REFERENCES coursesduration(id)
              ON UPDATE CASCADE
              DEFERRABLE,
    modality_id int4 NOT NULL 
            REFERENCES modality(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    hoursxweek int4 NULL,
    year int4 NOT NULL,
    month int4 NULL CHECK (month >= 1 AND month <= 12),
    location text NULL,
    acadprogram text NULL,
    other text NULL,
    PRIMARY KEY (id),
    CONSTRAINT either_course_or_group CHECK (courses_id IS NOT NULL OR
	coursegroup_id IS NOT NULL)
);
COMMENT ON TABLE usercourses IS
	'Cursos a los que está asociado un usuario';
COMMENT ON COLUMN usercourses.acadprogram IS
	'Carrera o programa académico a que este curso pertenece';
