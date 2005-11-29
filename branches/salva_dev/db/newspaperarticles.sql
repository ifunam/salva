CREATE TABLE newspapers ( 
	id SERIAL,
	name text NOT NULL,
	url text NULL,
        moduser_id int4 NULL    	     -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
	PRIMARY KEY (id),
	UNIQUE(name)
);
COMMENT ON TABLE newspapers IS
	'Periódicos';

CREATE TABLE newspaper_articles (
	id serial,
	title text NOT NULL,
	authors text NOT NULL,
        newspaper_id int4 NOT NULL 
            REFERENCES newspapers(id)
            ON UPDATE CASCADE        
            DEFERRABLE,	
 	newsdate date NOT NULL,
	pages text NULL,
	url text NULL,
	PRIMARY KEY (id),
	UNIQUE (title, newspaper_id, newsdate)
);
COMMENT ON TABLE newspaper_articles IS
	'Artículos publicados en periódico';

CREATE TABLE usernewspaper_articles ( 
    id SERIAL,
    user_id int4 NOT NULL 
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    newspaperarticle_id int4 NOT NULL 
            REFERENCES newspaper_articles(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    ismainauthor BOOLEAN NOT NULL default 't',
    other text NULL,
    dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, newspaperarticle_id)
);
COMMENT ON TABLE usernewspaper_articles IS
	'Autores de un artículo periodístico';
COMMENT ON COLUMN usernewspaper_articles.ismainauthor IS
	'Registramos únicamente si es el autor primario o no';

CREATE TABLE newspaper_articleslog (
    id SERIAL, 
    newspaperarticle_id integer NOT NULL 
            REFERENCES  newspaper_articles(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    old_articlestatus_id integer NOT NULL 
            REFERENCES articlestatuses(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    changedate date NOT NULL default now()::date,
    moduser_id integer NULL      -- It will be used only to know who has
            REFERENCES users(id) -- inserted, updated or deleted  
            ON UPDATE CASCADE    -- data into or from this table.
            DEFERRABLE,
    dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
COMMENT ON TABLE newspaper_articleslog IS
	'Cambios en el estado de los artículos periodísticos';

------
-- Update newspaper_articleslog if there was a status change
------
CREATE OR REPLACE FUNCTION newspaper_articles_update() RETURNS TRIGGER 
SECURITY DEFINER AS '
DECLARE 
BEGIN
	IF OLD.articlestatus_id = NEW.articlestatus_id THEN
		RETURN NEW;
	END IF;
	INSERT INTO newspaper_articleslog (newspaperarticle_id, 
		old_articlestatus_id, moduser_id) 
		VALUES (OLD.id, OLD.articlestatus_id, OLD.moduser_id);
        RETURN NEW;
END;
' LANGUAGE 'plpgsql';

CREATE TRIGGER newspaper_articles_update BEFORE DELETE ON newspaper_articles
	FOR EACH ROW EXECUTE PROCEDURE newspaper_articles_update();
