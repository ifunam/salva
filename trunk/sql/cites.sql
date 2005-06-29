-----------
-- cites --
-----------

-- Each of the cites this user's works have
CREATE TABLE cites ( 
   id int4 NOT NULL, -- id de la cita utilizado en la tabla de la que proviene
   citetype_id int4 NOT NULL  		 -- ID para identificar la tabla en donde se registro la información de esta cita.
            REFERENCES collections(id)  
            ON UPDATE CASCADE
            DEFERRABLE,
   citedwork_id int4 NOT NULL, -- ID del trabajo citado en esta cita
   reftocollection_id int4 NOT NULL  -- Indicaremos el <<id de la tabla>> en donde esta registrado el trabajo
	    REFERENCES collections(id)    -- citado
            ON UPDATE CASCADE
            DEFERRABLE,
   moduser_id int4 NOT NULL      -- It will be used only to know who has
            REFERENCES users(id) -- inserted, updated or deleted  
            ON UPDATE CASCADE    -- data into or from this table.
            DEFERRABLE,
    dbuser text DEFAULT CURRENT_USER,
    dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id, citetype_id, citedwork_id, reftocollection_id)
);


CREATE OR REPLACE FUNCTION check_cites() RETURNS TRIGGER AS '
DECLARE 
	collections RECORD;
	reftocollections RECORD;
BEGIN

	FOR collections IN SELECT tablename FROM collections WHERE id = NEW.citetype_id;
	IF NOT FOUND THEN
    		RAISE EXCEPTION ''citetype_id % not found in collections table'', NEW.citetype_id;
	ELSE
		SELECT id FROM collections.tablename WHERE id = NEW.id;
		IF NOT FOUND THEN
    			RAISE EXCEPTION ''id % not found in the table %'', NEW.id, collections.tablename;
		END IF;
	END IF;

	FOR reftocollections IN SELECT tablename FROM collections WHERE id = NEW.reftocollection_id;
	IF NOT FOUND THEN
    		RAISE EXCEPTION ''reftocollection_id % not found in collections table'', NEW.reftocollection_id;
	ELSE
		SELECT id FROM reftocollections.tablename WHERE id = NEW.citedwork_id;
		IF NOT FOUND THEN
    			RAISE EXCEPTION ''citedwork_id % not found in the table %'', NEW.citedwork_id, reftocollections.tablename;
		END IF;
	END IF;

        RETURN NEW;		
END;
' LANGUAGE 'plpgsql';



CREATE TRIGGER cites_insert BEFORE INSERT ON cites FOR EACH ROW EXECUTE PROCEDURE check_cites();
CREATE TRIGGER cites_update BEFORE UPDATE ON cites FOR EACH ROW EXECUTE PROCEDURE check_cites();
