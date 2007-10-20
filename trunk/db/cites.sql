--------------------
-- Cites -- 
--------------------
CREATE TABLE user_cites (
    id SERIAL,
    user_id int4 NOT NULL
            REFERENCES users(id)     
            ON UPDATE CASCADE   
            ON DELETE CASCADE  
            DEFERRABLE,
    total int4 NOT NULL,
    moduser_id int4  NULL    	     -- Use it only to know who has
    		REFERENCES users(id)             -- inserted, updated or deleted  
    		ON UPDATE CASCADE                -- data into or from this table.
    		DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,

    UNIQUE (user_id)
);

------------------------------
-- Log table for user_cites --
------------------------------
CREATE TABLE user_cites_logs (
    id serial,
    user_id int4 NOT NULL,
    total int4 NOT NULL,
    year int4 NOT NULL,
    moduser_id integer NULL,      -- It will be used only to know who has
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

CREATE OR REPLACE FUNCTION user_cites_update() RETURNS TRIGGER
SECURITY DEFINER AS '
DECLARE
		old_year integer;
BEGIN
        IF (date_part(''year'',OLD.updated_on::date) < date_part(''year'',CURRENT_TIMESTAMP::date))  THEN
		old_year = date_part(''year'',CURRENT_TIMESTAMP::date);
        INSERT INTO user_cites_logs (user_id, total, year, moduser_id) VALUES (OLD.user_id, OLD.total, old_year,  OLD.moduser_id);
		END IF;
		RETURN NEW;
END;
' LANGUAGE 'plpgsql';

CREATE TRIGGER user_cites_update BEFORE UPDATE ON user_cites
        FOR EACH ROW EXECUTE PROCEDURE user_cites_update();