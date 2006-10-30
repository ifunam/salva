----------------------------
-- Articles and journals --
----------------------------

CREATE TABLE publicationcategories ( 
	id SERIAL,
	name varchar(50) NOT NULL,
	descr text NULL,
	moduser_id int4 NULL               	    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE(name)
);
COMMENT ON TABLE publicationcategories IS 
	'Áreas del conocimiento a los que responde una revista:
	 Genéricos: Ciencias sociales, ciencias naturales, humanidades
	 Específicos: (desglose :)';

CREATE TABLE journaltypes ( 
	id SERIAL,
	name varchar(50) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE(name)
);
COMMENT ON TABLE journaltypes IS
	'Tipo de revista que publica (arbitrada/no arbitrada):
	 Arbitrada, no arbitrada, otra?';

CREATE TABLE journals (
        id SERIAL,
        name text NOT NULL,
	issn text NULL,
        url  text NULL,
        abbrev text NULL,      
        other text NULL,           
	totalcites integer NULL,
	impactfactor float NULL, 	
	immediacy   text NULL,
	dateupdate date NULL, 
	journaltype_id int4 NOT NULL 
            	REFERENCES journaltypes(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	mediatype_id int4 NOT NULL 
            	REFERENCES mediatypes(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	publisher_id int4 NOT NULL 
            	REFERENCES publishers(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	country_id int4 NOT NULL 
            	REFERENCES countries(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	moduser_id int4 NULL               	    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY(id),
	UNIQUE(issn) 
);
COMMENT ON TABLE journals IS
	'Revistas en las cuales pueden publicarse artículos';
COMMENT ON COLUMN journals.dateupdate IS
	'Fecha en que fué actualizado el factor de impacto/inmediatez';

CREATE TABLE journal_publicationcategories ( 
	id SERIAL,
	journal_id int4 NOT NULL 
            REFERENCES journals(id)      
            ON UPDATE CASCADE
            DEFERRABLE,
    	publicationcategory_id int4 NOT NULL 
            REFERENCES publicationcategories(id)      
            ON UPDATE CASCADE
            DEFERRABLE,
	moduser_id int4 NULL               	    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE(journal_id, publicationcategory_id)
);
COMMENT ON TABLE journal_publicationcategories IS
	'Categorías (áreas del conocimiento) a las que pertenece una revista';

CREATE TABLE roleinjournals (
	id serial,
	name text NOT NULL,
	PRIMARY KEY(id),
	UNIQUE (name)
);
COMMENT ON TABLE roleinjournals IS
	'Roles que un usuario puede tener en una publicación:
	Editor, Compilador, Revisor, Arbitro, Otro';


CREATE TABLE user_journals ( 
	id SERIAL,
    	user_id int4 NOT NULL 
        	REFERENCES users(id)      
            	ON UPDATE CASCADE
            	ON DELETE CASCADE   
            	DEFERRABLE,
	journal_id int4 NOT NULL 
        	REFERENCES journals(id)
            	ON UPDATE CASCADE
            	DEFERRABLE,
	roleinjournal_id int4 NOT NULL 
        	REFERENCES roleinjournals(id)
            	ON UPDATE CASCADE
            	DEFERRABLE,
	startyear int4 NOT NULL,
	startmonth int4 NULL CHECK (startmonth >= 1 AND startmonth <= 12),
	endyear   int4 NULL,
	endmonth int4 NULL CHECK (endmonth >=1 AND endmonth <= 12),
	numcites int4 NULL CHECK (numcites >= 0),
	other text NULL,
	moduser_id int4 NULL               	    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	CONSTRAINT valid_duration CHECK (endyear IS NULL OR
	       (startyear * 12 + coalesce(startmonth,0)) > (endyear * 12 + coalesce(endmonth,0)))
);
COMMENT ON TABLE user_journals IS
	'Relación entre usuarios del sistema y las publicaciones';
COMMENT ON COLUMN user_journals.roleinjournal_id IS
	'Es el rol que tiene el usuario en la publicación';


CREATE TABLE articles ( 
    id SERIAL,
    title text NOT NULL,
    journal_id int4 NOT NULL 
            REFERENCES journals(id)      
            ON UPDATE CASCADE
            DEFERRABLE,
    articlestatus_id int4 NOT NULL  
            REFERENCES articlestatuses(id)      
            ON UPDATE CASCADE
            DEFERRABLE,
    pages text NULL,   
    year  int4 NOT NULL,
    month  int4 NULL CHECK (month >= 1 AND month <= 12),
    vol text NULL,
    num text NULL,
    authors text NULL ,
    url text NULL,
    pacsnum text NULL,
    other text NULL,
    moduser_id int4 NULL               	    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE(title, journal_id, year)
);
COMMENT ON TABLE articles IS
	'Datos de un artículo publicado';
COMMENT ON COLUMN articles.authors IS
	'Listado de autores tal cual aparece en el artículo - La relación 
	entre usuarios y artículos es independiente de esta, ver 
	authorarticles.';

CREATE TABLE user_articles ( 
    id SERIAL,
    user_id int4 NOT NULL 
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    article_id int4 NOT NULL 
            REFERENCES articles(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    ismainauthor BOOLEAN NOT NULL default 't',
    other text NULL,
    moduser_id int4 NULL               	    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, article_id)
);
COMMENT ON TABLE user_articles IS
	'Relación entre usuarios del sistema y artículos';
COMMENT ON COLUMN user_articles.ismainauthor IS
	'Basta con señalar si el usuario es autor principal o es coautor';

CREATE TABLE articleslog (
    id SERIAL, 
    article_id integer NOT NULL 
            REFERENCES articles(id)
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
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
COMMENT ON TABLE articleslog IS
	'Estado actual (y bitácora) de un artículo - Cuándo fue enviado, 
	cuándo fue aceptado, etc.';

CREATE TABLE file_articles (
   id serial NOT NULL,
   article_id int4 NOT NULL
            REFERENCES articles(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   filename text NOT NULL,
   conten_type text NULL,
   content bytea NOT NULL,
   creationtime timestamp NOT NULL DEFAULT now(),
   lastmodiftime timestamp NOT NULL DEFAULT now(),
   moduser_id int4 NULL      -- It will be used only to know who has
            REFERENCES users(id) -- inserted, updated or deleted  
            ON UPDATE CASCADE    -- data into or from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (article_id, filename)
);
COMMENT ON TABLE file_articles IS
	'Archivos relacionados a los artículos';
COMMENT ON COLUMN file_articles.article_id IS
	'ID del artículo referenciado';
COMMENT ON COLUMN file_articles.content IS
	'Contenido (binario) del archivo';



------
-- Update articleslog if there was a status change
------
-- CREATE OR REPLACE FUNCTION articles_update() RETURNS TRIGGER 
-- SECURITY DEFINER AS '
-- DECLARE 
-- BEGIN
-- 	IF OLD.articlestatus_id = NEW.articlestatus_id THEN
-- 		RETURN NEW;
-- 	END IF;
-- 	INSERT INTO articleslog (articles_id, old_articlestatus_id, moduser_id)
-- 		VALUES (OLD.id, OLD.articlestatus_id, OLD.moduser_id);
--         RETURN NEW;
-- END;
-- ' LANGUAGE 'plpgsql';

-- CREATE TRIGGER articles_update BEFORE DELETE ON articles
-- 	FOR EACH ROW EXECUTE PROCEDURE articles_update();
