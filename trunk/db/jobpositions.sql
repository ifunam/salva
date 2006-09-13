-- De acuerdo al manual de categorías y tabuladores de sueldos de la UNAM
-- se establecen las siguientes tablas

-- Ejemplo de puesto: Un Investigador Ordinario Asociado C de Tiempo Completo:
--     jobpositioncategories: Investigador Ordinario
--     jobpositionlevels: Asociado C TC
--     jobpositiontypes: (el ID que corresponda a Investigación)
CREATE TABLE jobpositiontypes (  
	id SERIAL,		
	name text NOT NULL,   	
	PRIMARY KEY (id), 	
	UNIQUE (name)           
);
COMMENT ON TABLE jobpositiontypes IS 
	'Tipos de personal:
	Las cuatro posibilidades que entran a esta tabla son:
	Personal académico para docencia: Investigador y técnico académico * usa niveles *
	Personal académico para investigación: Investigador y técnico académico * usa niveles *
	Personal administrativo de base * usa ramas *	  
	Personal administrativo de confianza	* NO usa niveles NI ramas * ';

CREATE TABLE roleinjobpositions (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE roleinjobpositions IS 
	'Rol desempeñado: técnico académico, investigador, ayudante, etc.';


CREATE TABLE jobpositionlevels (
	id SERIAL,		
	name text NOT NULL,     
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE jobpositionlevels IS 
	'Niveles (para académicos) o ramas (para administrativos) de 
	contratación: 
	Nivel A, Nivel B, Nivel C,
	Rama administrativa, rama obrera, rama...';


CREATE TABLE jobpositioncategories (
	id SERIAL,
	jobpositiontype_id smallint NOT NULL 
                         REFERENCES jobpositiontypes(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
	roleinjobposition_id smallint NOT NULL 
                         REFERENCES roleinjobpositions(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
	jobpositionlevel_id smallint NOT NULL 
                         REFERENCES jobpositionlevels(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
	administrative_key text NULL, 
	PRIMARY KEY (id),
	UNIQUE (jobpositiontype_id, roleinjobposition_id, jobpositionlevel_id)
);
COMMENT ON TABLE jobpositioncategories IS 
	'Los puestos existentes en la UNAM, dependientes de jobpositiontypes y
	jobpositionlevels:  Investigador ordinario, técnico académico, ...';
COMMENT ON COLUMN jobpositioncategories.administrative_key IS
	'ID administrativo de la adscripción en la universidad - Lo mantenemos
	únicamente como descripción en texto';

CREATE TABLE contracttypes (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE contracttypes IS 
	'Tipos de contratación: Definitivo, temporal, Art. 51, ...';

CREATE TABLE jobpositions (
	id SERIAL, 
	user_id int4 NOT NULL 
            REFERENCES users(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
	jobpositioncategory_id smallint NULL 
                         REFERENCES jobpositioncategories(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
	contracttype_id integer NULL
		REFERENCES contracttypes(id)
		ON UPDATE CASCADE
		DEFERRABLE,
	institution_id int4 NOT NULL 
            	REFERENCES institutions(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	descr text NULL,
	startmonth int4 NULL CHECK (startmonth<=12 AND startmonth>=1),
	startyear int4 NOT NULL,
	endmonth int4 NULL CHECK (endmonth<=12 AND endmonth>=1),
	endyear  int4 NULL,
        moduser_id int4  NULL    	     -- Use it only to know who has
    	REFERENCES users(id)             -- inserted, updated or deleted  
    	ON UPDATE CASCADE                -- data into or from this table.
              DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id)
--	CONSTRAINT valid_duration CHECK (endyear IS NULL OR
--	       (startyear * 12 + coalesce(startmonth,0)) > (endyear * 12 + coalesce(endmonth,0)))
);
COMMENT ON TABLE jobpositions IS 
	'Relación entre un usuario y todos los datos que describen a su puesto
	(incluye periodos, para construir la historia laboral)';
COMMENT ON COLUMN jobpositions.jobpositioncategory_id IS
	'Puesto en que laboró en la UNAM - En caso de ser personal por 
	honorarios, queda nulo (no hay catálogo de puestos por honorarios),
	manejando sólo la descripción, y asociando a la institución adecuada.';

CREATE TABLE stimulustypes (
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
COMMENT ON TABLE stimulustypes IS 
	'Tipos de estímulos:
	{PAIPA, Programa de Apoyo a la Incorporación de Personal Académico, UNAM},
	{PRIDE, Programa de Reconocimiento a la Investigación y Desarrollo
	Académico, UNAM}, {SNI, Sistema Nacional de Investigadores, CONACyT}, ...';
COMMENT ON COLUMN stimulustypes.name IS 
	'Nombre corto/abreviación del estímulo';
COMMENT ON COLUMN stimulustypes.descr IS 
	'Nombre completo del estímulo';
COMMENT ON COLUMN stimulustypes.institution_id IS 
	'Institución que lo otorga';


CREATE TABLE stimuluslevels (
	id SERIAL,
	name text NOT NULL,
	stimulustype_id int4 NOT NULL
		REFERENCES stimulustypes(id)
		ON UPDATE CASCADE
		DEFERRABLE,
	PRIMARY KEY (id),
	UNIQUE (name, stimulustype_id)
);
COMMENT ON TABLE stimuluslevels IS 
	'Niveles de estímulos para cada uno de los tipos';
	-- PAIPA: A, B, C, D
	-- PRIDE: A, B, C, D, E
	-- SNI: I, II, III
	-- SNC: ???

CREATE TABLE user_stimulus (
	id SERIAL, 
	user_id int4 NOT NULL 
            REFERENCES users(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
	stimuluslevel_id INT4 NOT NULL 
                         REFERENCES stimuluslevels(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
	startyear int4 NOT NULL,
	startmonth int4 NULL CHECK (startmonth<=12 AND startmonth>=1),
	endyear  int4 NULL,
	endmonth int4 NULL CHECK (endmonth<=12 AND endmonth>=1),
	PRIMARY KEY (id)
--	CONSTRAINT valid_duration CHECK (endyear IS NULL OR
--	       (startyear * 12 + coalesce(startmonth,0)) > (endyear * 12 + coalesce(endmonth,0)))
);
COMMENT ON TABLE user_stimulus IS 
	'Estímulos con que ha contado un usuario, incluyendo nivel, con fecha
	de inicio/término';

-- NOTA
-- Encontrar un mecanismo para evitar más de un nivel de estímulos del mismo
-- tipo (p.ej. PRIDE A y PRIDE B) en el mismo momento

CREATE TABLE stimulusstatus (
	id SERIAL, 
	name varchar(50) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE(name)
);
COMMENT ON TABLE stimulusstatus IS 
	'Estados de cada cambio de nivel de estímulos';
-- solicitado, aprobado, rechazado, en proceso

CREATE TABLE stimuluslogs (
    id SERIAL, 
    stimulus_id integer NOT NULL 
            REFERENCES user_stimulus(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    old_stimulusstatus_id integer NOT NULL 
            REFERENCES stimulusstatus(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    changedate date NOT NULL default now()::date,
    moduser_id integer NULL      -- It will be used only to know who has
            REFERENCES users(id) -- inserted, updated or deleted  
            ON UPDATE CASCADE    -- data into or from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
COMMENT ON TABLE stimuluslogs IS 
	'Fecha de cambio de estado de solicitudes de nivel estímulos';

-- Name for the area a user works in - "Departamento de Cómputo", "Unidad
-- de blah", "Secretaría Fulana", "Dirección"
CREATE TABLE adscriptions (
	id serial,
	name text NOT NULL,
	abbrev text NULL, 
	descr text NULL,
	institution_id int4 NOT NULL
		REFERENCES institutions(id)
		ON UPDATE CASCADE
		DEFERRABLE,
	administrative_key text NULL, -- An ID for the adscriptions in the
			-- university - we only keep it as text, no
			-- referential integrity is attempted.
    	moduser_id integer NULL      -- It will be used only to know who has
            REFERENCES users(id) -- inserted, updated or deleted  
            ON UPDATE CASCADE    -- data into or from this table.
            DEFERRABLE,
    	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id),
	UNIQUE(name, institution_id)
);
COMMENT ON TABLE adscriptions IS 
	'Nombre de las adscripciones registradas';
COMMENT ON COLUMN adscriptions.administrative_key IS
	'ID administrativo de la adscripción en la universidad - Lo mantenemos
	únicamente como descripción en texto';

-- We are stating here the work period, which is also in jobpositions - Why?
-- Because a user might retain his jobposition (category/level/...) but the
-- adscriptions he works at can be renamed or change.
CREATE TABLE user_adscriptions (
	id SERIAL,
	jobposition_id int4 NOT NULL 
                         REFERENCES jobpositions(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
	adscription_id int4 NOT NULL 
                         REFERENCES adscriptions(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
        name text NULL,
        descr text NULL,
	startmonth int4 NULL CHECK (startmonth<=12 AND startmonth>=1),
	startyear int4 NOT NULL,
	endmonth int4 NULL CHECK (endmonth<=12 AND endmonth>=1),
	endyear  int4 NULL,
    	moduser_id integer NULL      -- It will be used only to know who has
            REFERENCES users(id) -- inserted, updated or deleted  
            ON UPDATE CASCADE    -- data into or from this table.
            DEFERRABLE,
    	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id)
);
COMMENT ON TABLE user_adscriptions IS 
	'Adscripción a la que pertenece un usuario en determinado periodo';
COMMENT ON COLUMN user_adscriptions.name IS
	'Describir el nombre de la participación institucional: Jefe de departamento, Coordinador, etc';
COMMENT ON COLUMN user_adscriptions.descr IS
	'Se usa para describir las funciones o actividades del puesto institucional';
COMMENT ON COLUMN user_adscriptions.startyear IS
	'El periodo aparece tanto aquí como en jobpositions ya que un 
	usuario puede cambiar de adscripción sin cambiar su categoría';

CREATE TABLE jobposition_logs (
	id serial,
	user_id int4 NOT NULL 
            REFERENCES users(id)
            ON UPDATE CASCADE	
            ON DELETE CASCADE   	
            DEFERRABLE,
	administrative_key text NOT NULL,
	years integer NOT NULL CHECK (years >=1),
    	moduser_id integer NULL      -- It will be used only to know who has
            REFERENCES users(id) -- inserted, updated or deleted  
            ON UPDATE CASCADE    -- data into or from this table.
            DEFERRABLE,
    	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id),
	UNIQUE(user_id)
);
COMMENT ON TABLE jobposition_logs IS
	'Antiguedad del usuario en la UNAM';
COMMENT ON COLUMN jobposition_logs.administrative_key IS
	'Número de trabajador en la UNAM (es único)';
COMMENT ON COLUMN jobposition_logs.years IS
	'Número de años trabajando en UNAM (Se calculará el número a partir de la información de la tabla jobpositions';

------	
-- Update stimuluslogs if there was a status change
------
CREATE OR REPLACE FUNCTION stimulus_update() RETURNS TRIGGER 
SECURITY DEFINER AS '
DECLARE 
BEGIN
	IF OLD.stimulusstatus_id = NEW.stimulusstatus_id THEN
		RETURN NEW;
	END IF;
	INSERT INTO stimuluslogs (stimulus_id, old_stimulusstatus_id, 
		moduser_id) 
		VALUES (OLD.id, OLD.stimulusstatus_id, OLD.moduser_id);
        RETURN NEW;
END;
' LANGUAGE 'plpgsql';

CREATE TRIGGER stimulus_update BEFORE DELETE ON user_stimulus
	FOR EACH ROW EXECUTE PROCEDURE stimulus_update();
