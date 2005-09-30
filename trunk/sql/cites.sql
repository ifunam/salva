-----------
-- cites --
-----------

-- Each of the cites this user's works have
CREATE TABLE cites ( 
   citingwork_id int4 NOT NULL,
   citingtype_id int4 NOT NULL
            REFERENCES collections(id)  
            ON UPDATE CASCADE
            DEFERRABLE,
   citedwork_id int4 NOT NULL,
   citedtype_id int4 NOT NULL
	    REFERENCES collections(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   moduser_id int4 NULL      -- It will be used only to know who has
            REFERENCES users(id) -- inserted, updated or deleted  
            ON UPDATE CASCADE    -- data into or from this table.
            DEFERRABLE,
    dbuser text DEFAULT CURRENT_USER,
    dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (citingwork_id, citingtype_id, citedwork_id, citedtype_id)
);
COMMENT ON TABLE cites IS
	'Citas a los trabajos de los usuarios';
COMMENT ON COLUMN cites.citingwork_id IS
	'ID del trabajo citante en su tabla (indicada por citingtype_id)';
COMMENT ON COLUMN cites.citingtype_id IS
	'ID de la tabla (ver collections) a la que pertenece el trabajo 
	citante';
COMMENT ON COLUMN cites.citedwork_id IS
	'ID del trabajo citado en su tabla (indicada por citedtype_id)';
COMMENT ON COLUMN cites.citedtype_id IS
	'ID de la tabla (ver collections) a la que pertenece el trabajo 
	citado';

-- CREATE OR REPLACE FUNCTION check_cites() RETURNS TRIGGER AS '
-- DECLARE 
-- 	collections RECORD;
-- 	reftocollections RECORD;
-- BEGIN

-- 	FOR collections IN SELECT tablename FROM collections WHERE id = NEW.citetype_id;
-- 	IF NOT FOUND THEN
--     		RAISE EXCEPTION ''citetype_id % not found in collections table'', NEW.citetype_id;
-- 	ELSE
-- 		SELECT id FROM collections.tablename WHERE id = NEW.id;
-- 		IF NOT FOUND THEN
--     			RAISE EXCEPTION ''id % not found in the table %'', NEW.id, collections.tablename;
-- 		END IF;
-- 	END IF;

-- 	FOR reftocollections IN SELECT tablename FROM collections WHERE id = NEW.reftocollection_id;
-- 	IF NOT FOUND THEN
--     		RAISE EXCEPTION ''reftocollection_id % not found in collections table'', NEW.reftocollection_id;
-- 	ELSE
-- 		SELECT id FROM reftocollections.tablename WHERE id = NEW.citedwork_id;
-- 		IF NOT FOUND THEN
--     			RAISE EXCEPTION ''citedwork_id % not found in the table %'', NEW.citedwork_id, reftocollections.tablename;
-- 		END IF;
-- 	END IF;

--         RETURN NEW;		
-- END;
-- ' LANGUAGE 'plpgsql';



-- CREATE TRIGGER cites_insert BEFORE INSERT ON cites FOR EACH ROW EXECUTE PROCEDURE check_cites();
-- CREATE TRIGGER cites_update BEFORE UPDATE ON cites FOR EACH ROW EXECUTE PROCEDURE check_cites();
