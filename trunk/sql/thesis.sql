------------
-- Thesis --
------------

CREATE TABLE thesisstatus (
    id SERIAL,
    name text NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);
COMMENT ON TABLE thesisstatus IS 
	'Estado de avance de la tesis';
-- En proceso, aprobada, publicada, ...

CREATE TABLE thesismodality (
    id SERIAL,
    name text NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);
COMMENT ON TABLE thesismodality IS 
	'Modalidad del trabajo generado';
-- Tesis, tesina, informe académico, ...

CREATE TABLE roleinthesis (
    id SERIAL,
    name text NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);
COMMENT ON TABLE roleinthesis IS 
	'Roles en una tesis';
-- Rol del usuario en la tesis: Director, tutor o asesor, ...
-- Se considera participaciÃn³en comitÃs tutoriales cuando
-- el usuario NO es director de tesis. Por ejemplo:
-- Un comitÃ© tutorial puede estar integrado po el director 
-- de tesis y dos Asesores.


CREATE TABLE thesis (
	id SERIAL NOT NULL,
    	title text NOT NULL,
	institution_id integer NOT NULL 
	    REFERENCES institutions(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    	academicdegree_id integer NOT NULL
            REFERENCES academicdegrees(id) 
            ON UPDATE CASCADE              
            DEFERRABLE,
    	thesisstatus_id integer NOT NULL
	    REFERENCES thesisstatus(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    	thesismodality_id integer NOT NULL 
	    REFERENCES thesismodality(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
	academiccareer_id int4 NOT NULL 
            	REFERENCES academiccareers(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	year int4 NOT NULL,
	month int4 NULL CHECK (month >= 1 AND month <= 12),
	moduser_id integer NULL      -- It will be used only to know who has
            REFERENCES users(id) -- inserted, updated or deleted  
            ON UPDATE CASCADE    -- data into or from this table.
            DEFERRABLE,
	PRIMARY KEY (id),
    	UNIQUE (title, academicdegree_id, year)
);
COMMENT ON TABLE thesis IS 
	'Datos generales de cada una de las tesis';
COMMENT ON COLUMN thesis.academicdegree_id IS
	'Grado académico que esta tesis persigue';

CREATE TABLE userthesis (
   id SERIAL,
   thesis_id integer NOT NULL 
            REFERENCES thesis(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   roleinthesis_id integer NOT NULL
            REFERENCES roleinthesis(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   user_is_internal bool,
   externaluser_id integer NULL 
            REFERENCES externalusers(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
   internaluser_id integer NULL
            REFERENCES users(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
   PRIMARY KEY (id),
   -- Sanity checks: If the user is a full system user, require the user
   -- to be filled in. Likewise for an external one.
   CHECK (user_is_internal = 't' OR
	(internaluser_id IS NOT NULL AND externaluser_id IS NULL)),
   CHECK (user_is_internal = 'f' OR
	(externaluser_id IS NOT NULL AND internaluser_id IS NULL)),
   -- By having only internal or external present, we can make this UNIQUE
   -- constraint on thesis_id and both of them, and then have unicity on
   -- (anyuser, thesis_id).
   UNIQUE (thesis_id, externaluser_id, internaluser_id)
);
COMMENT ON TABLE userthesis IS 
	'La relación entre un usuario (en rol de director/asesor/etc.) y una
	tesis';
COMMENT ON COLUMN userthesis.user_is_internal IS
	'El usuario es interno del sistema? Si sí, exigimos internaluser_id; 
	si no, exigimos externaluser_id';

CREATE TABLE thesislog (
    id SERIAL,
    thesis_id integer NOT NULL
            REFERENCES thesis(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    old_thesisstatus_id integer  NOT NULL 
	    REFERENCES thesisstatus(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    year int4 NOT NULL,
    month int4 NULL CHECK (month >= 1 AND month <= 12),
    moduser_id integer NULL      -- It will be used only to know who has
            REFERENCES users(id) -- inserted, updated or deleted  
            ON UPDATE CASCADE    -- data into or from this table.
            DEFERRABLE,
    dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
COMMENT ON TABLE thesislog IS 
	'Bitácora de cambios de estado en la tesis';

CREATE TABLE studentsthesis ( 
   id SERIAL,
   thesis_id integer NOT NULL 
            REFERENCES thesis(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
   user_is_internal bool, 
   externaluser_id integer 
            REFERENCES externalusers(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
   internaluser_id integer
            REFERENCES users(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
   PRIMARY KEY (id),
   UNIQUE (thesis_id, internaluser_id ),
   UNIQUE (thesis_id, externaluser_id ),
   -- Sanity checks: If the user is an full system user, require the user
   -- to be filled in. Likewise for an external one.
   CHECK (user_is_internal = 't' or internaluser_id IS NOT NULL),
   CHECK (user_is_internal = 'f' or externaluser_id IS NOT NULL)
);
COMMENT ON TABLE studentsthesis IS 
	'Relación entre un usuario (en rol de alumno) y una tesis';
COMMENT ON COLUMN studentsthesis.user_is_internal IS
	'El usuario es interno del sistema? Si sí, exigimos internaluser_id; 
	si no, exigimos externaluser_id';

CREATE TABLE roleindissertation (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);
-- Role in thesis presentations or dissertations.
-- Jurado de examenes: Presidente, Secretario, Vocal, ...

CREATE TABLE userdissthesis (
   id SERIAL,
   user_id integer NULL
            REFERENCES users(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
   thesis_id integer NOT NULL 
            REFERENCES thesis(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   roleindissertation_id integer NOT NULL
            REFERENCES roleindissertation(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   year integer NOT NULL,
   month integer NULL,
   PRIMARY KEY (id),
   UNIQUE (thesis_id, user_id, roleindissertation_id)
);
COMMENT ON TABLE userdissthesis IS 
	'La relación entre un usuario, el rol en la disertaciÃn
	(sinodal, presidente, secretario y vocal) y la tesis';

