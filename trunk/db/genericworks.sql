CREATE TABLE genericworkgroups (
	id serial,
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
COMMENT ON TABLE genericworkgroups IS
	'Listado del grupo al que pertenecen las trabajos genericos:
	Productos de divulgación
	Productos de extensión y difusión
	Publicaciones internas
	Productos de docencia
	Otro';


CREATE TABLE genericworktypes (
	id serial,
	name text NOT NULL,
	abbrev text NULL,
	genericworkgroup_id int4 NOT NULL 
	    REFERENCES genericworkgroups(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
        moduser_id int4 NULL               	    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
        created_on timestamp DEFAULT CURRENT_TIMESTAMP,
        updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE (name,genericworkgroup_id)
);
COMMENT ON TABLE genericworktypes IS 
	'Tipos de trabajos genéricos que manejamos:

	Productos de divulgación:
	Reportes técnicos públicos
	Artículos In extenso
	Artículos en memorias
	Artículos o ensayos en revistas
	Divulgación de la ciencia
	Nota de investigación
	Reseña
	...

	Productos de extensión y difusión:
	Colecciones (infantiles, impresos)
	....

	Publicaciones internas:
	Reportes técnicos internos
	Gaceta
	...

	Productos de docencia:
	Antología
	Antología critica
	Guía de estudio
	Notas de clase
	Cuadernos
	Manual de apoyo docente
	Catalogos
	...

	Otro:
	Traducción de artículo
	 ...
       ';


CREATE TABLE genericworkstatus (
	id serial,
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
COMMENT ON TABLE genericworkstatus IS 
	'Estado de un trabajo genérico:
	Propuesto, enviado, aceptado, en prensa, publicado, ..';

CREATE TABLE genericworks( 
    id SERIAL,
    authors text NOT NULL,
    title   text NOT NULL,
    genericworktypes_id int4 NOT NULL     
            REFERENCES genericworktypes(id)
            ON UPDATE CASCADE 
            DEFERRABLE,
    genericworkstatus_id int4 NOT NULL     
            REFERENCES genericworkstatus(id)
            ON UPDATE CASCADE 
            DEFERRABLE,
    institution_id integer NULL 
	    REFERENCES institutions(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    publisher_id int4 NULL 
            	REFERENCES publishers(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
    reference text NULL,
    vol text NULL,
    pages text NULL,
    year int4 NOT NULL,
    month int4 NULL CHECK (month >= 1 AND month <= 12),
    isbn_issn text NULL,
    numcites int4 NULL CHECK (numcites >= 0),
    other text NULL,
    moduser_id int4 NULL               	    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
COMMENT ON TABLE genericworks IS 
	'Trabajos genéricos (publicaciones no contempladas en otros 
	apartados del sistema)';
COMMENT ON COLUMN genericworks.isbn_issn IS
	'Dependiendo del tipo de trabajo, puede recibir número ISBN o ISSN';
	
CREATE TABLE usergenericworks (
   id SERIAL,
   genericwork_id int4 NOT NULL 
            REFERENCES genericworks(id)
            ON UPDATE CASCADE
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
   userrole_id integer NOT NULL 
            REFERENCES userrole(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   moduser_id int4 NULL               	    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
   created_on timestamp DEFAULT CURRENT_TIMESTAMP,
   updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (id),
   UNIQUE (genericwork_id, internaluser_id ),
   UNIQUE (genericwork_id, externaluser_id ),
   -- Sanity checks: If this is a full system user, require the user
   -- to be filled in. Likewise for an external one.
   CHECK (user_is_internal = 't' OR
	(internaluser_id IS NOT NULL AND externaluser_id IS NULL)),
   CHECK (user_is_internal = 'f' OR
	(externaluser_id IS NOT NULL AND internaluser_id IS NULL))
);
COMMENT ON TABLE usergenericworks IS 
	'Rol de cada uno de los usuarios involucrados en un trabajo genérico';
COMMENT ON COLUMN usergenericworks.user_is_internal IS
	'Este usuario es interno o externo? Eige (NOT NULL) el tipo de usuario 
	adecuado: externaluser_id o internaluser_id';

CREATE TABLE usergenericworkslog (
    id SERIAL, 
    usergenericworks_id integer NOT NULL 
            REFERENCES articles(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    old_genericworkstatus_id integer NOT NULL 
            REFERENCES genericworkstatus(id)
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
COMMENT ON TABLE usergenericworkslog IS
	'Estado actual (y bitácora) de un trabajo genérico - Cuándo fue
	 enviado, cuándo fue aceptado, etc.';

------
-- Update usergenericworkslog if there was a status change
------
CREATE OR REPLACE FUNCTION usergenericworks_update() RETURNS TRIGGER 
SECURITY DEFINER AS '
DECLARE 
BEGIN
	IF OLD.genericworkstatus_id = NEW.genericworkstatus_id THEN
		RETURN NEW;
	END IF;
	INSERT INTO usergenericworkslog (usergenericworks_id, 
		old_usergenericworkstatus_id, moduser_id) VALUES
		(OLD.id, OLD.genericworkstatus_id, OLD.moduser_id);
        RETURN NEW;
END;
' LANGUAGE 'plpgsql';

CREATE TRIGGER usergenericworks_update BEFORE DELETE ON usergenericworks
	FOR EACH ROW EXECUTE PROCEDURE usergenericworks_update();
