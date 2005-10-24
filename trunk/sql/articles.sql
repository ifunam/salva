----------------------------
-- Articles and magazines --
----------------------------

CREATE TABLE publicationcategories ( 
	id SERIAL,
	name varchar(50) NOT NULL,
        moduser_id int4  NULL    	     -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
	PRIMARY KEY (id),
	UNIQUE(name)
);
COMMENT ON TABLE publicationcategories IS 
	'Áreas del conocimiento a los que responde una revista';
-- Genéricos: Ciencias sociales, ciencias naturales, humanidades
-- Específicos: (desglose :) )

CREATE TABLE magazinetype ( 
	id SERIAL,
	name varchar(50) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE(name)
);
COMMENT ON TABLE magazinetype IS
	'Tipo de revista que publica (arbitrada/no arbitrada)';
-- Arbitrada, no arbitrada

CREATE TABLE magazines (
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
	magazinetype_id int4 NOT NULL 
            	REFERENCES magazinetype(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	mediatype_id int4 NOT NULL 
            	REFERENCES mediatype(id) 
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
        moduser_id int4 NULL    -- Use it only to know who has
            REFERENCES users(id)    -- inserted, updated or deleted  
            ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
        PRIMARY KEY(id),
	UNIQUE(issn) 
);
COMMENT ON TABLE magazines IS
	'Revistas en las cuales pueden publicarse artículos';
COMMENT ON COLUMN magazines.dateupdate IS
	'Fecha en que fué actualizado el factor de impacto/inmediatez';

CREATE TABLE magazinepublicationcategory ( 
	id SERIAL,
	magazine_id int4 NOT NULL 
            REFERENCES magazines(id)      
            ON UPDATE CASCADE
            DEFERRABLE,
    	publicationcategory_id int4 NOT NULL 
            REFERENCES publicationcategories(id)      
            ON UPDATE CASCADE
            DEFERRABLE,
        moduser_id int4 NULL    	     -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
	PRIMARY KEY (id),
	UNIQUE(magazine_id, publicationcategory_id)
);
COMMENT ON TABLE magazinepublicationcategory IS
	'Categorías (áreas del conocimiento) a las que pertenece una revista';

CREATE TABLE roleinmagazine (
	id serial,
	name text NOT NULL,
	PRIMARY KEY(id),
	UNIQUE (name)
);
COMMENT ON TABLE roleinmagazine IS
	'Roles que un usuario puede tener en una publicación';
-- Editor, compilador, revisor, etc..


CREATE TABLE usermagazines ( 
	id SERIAL,
    	uid int4 NOT NULL 
        	REFERENCES users(id)      
            	ON UPDATE CASCADE
            	ON DELETE CASCADE   
            	DEFERRABLE,
	magazine_id int4 NOT NULL 
        	REFERENCES magazines(id)
            	ON UPDATE CASCADE
            	DEFERRABLE,
	roleinmagazine_id int4 NOT NULL 
        	REFERENCES roleinmagazine(id)
            	ON UPDATE CASCADE
            	DEFERRABLE,
	startyear int4 NOT NULL,
	startmonth int4 NULL CHECK (startmonth >= 1 AND startmonth <= 12),
	endyear   int4 NULL,
	endmonth int4 NULL CHECK (endmonth >=1 AND endmonth <= 12),
	numcites int4 NULL CHECK (numcites >= 0),
	other text NULL,
	dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	CONSTRAINT valid_duration CHECK (endyear IS NULL OR
	       (startyear * 12 + coalesce(startmonth,0)) > (endyear * 12 + coalesce(endmonth,0)))
);
COMMENT ON TABLE usermagazines IS
	'Relación entre usuarios del sistema y las publicaciones';
COMMENT ON COLUMN usermagazines.roleinmagazine_id IS
	'Es el rol que tiene el usuario en la publicación';


CREATE TABLE articles ( 
    id SERIAL,
    title text NOT NULL,
    pages text NULL,   
    year  int4 NOT NULL,
    month  int4 NULL CHECK (month >= 1 AND month <= 12),
    vol text NULL,
    num text NULL,
    authors text NULL ,
    url text NULL,
    pacsnum text NULL,
    artstatus_id int4 NOT NULL  
            REFERENCES articlestatus(id)      
            ON UPDATE CASCADE
            DEFERRABLE,
    magazine_id int4 NOT NULL 
            REFERENCES magazines(id)      
            ON UPDATE CASCADE
            DEFERRABLE,
    moduser_id int4 NULL         -- It will be used only to know who has
            REFERENCES users(id) -- inserted, updated or deleted  
            ON UPDATE CASCADE    -- data into or from this table.
            DEFERRABLE,
    other text NULL,
    PRIMARY KEY (id),
    UNIQUE(title, magazine_id, year)
);
COMMENT ON TABLE articles IS
	'Datos de un artículo publicado';
COMMENT ON COLUMN articles.authors IS
	'Listado de autores tal cual aparece en el artículo - La relación 
	entre usuarios y artículos es independiente de esta, ver 
	authorarticles.';

CREATE TABLE authorarticles ( 
    id SERIAL,
    uid int4 NOT NULL 
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
    dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (uid, article_id)
);
COMMENT ON TABLE authorarticles IS
	'Relación entre usuarios del sistema y artículos';
COMMENT ON COLUMN authorarticles.ismainauthor IS
	'Basta con señalar si el usuario es autor principal o es coautor';

CREATE TABLE articleslog (
    id SERIAL, 
    article_id integer NOT NULL 
            REFERENCES articles(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    old_artstatus_id integer NOT NULL 
            REFERENCES articlestatus(id)
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
COMMENT ON TABLE articleslog IS
	'Estado actual (y bitácora) de un artículo - Cuándo fue enviado, 
	cuándo fue aceptado, etc.';

CREATE TABLE filesarticles (
   id serial NOT NULL,
   article_id int4 NOT NULL
            REFERENCES articles(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   filename text NOT NULL,
   filedescr text NULL,
   content bytea NOT NULL,
   creationtime timestamp NOT NULL DEFAULT now(),
   lastmodiftime timestamp NOT NULL DEFAULT now(),
   moduser_id int4 NULL      -- It will be used only to know who has
            REFERENCES users(id) -- inserted, updated or deleted  
            ON UPDATE CASCADE    -- data into or from this table.
            DEFERRABLE,
    dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (article_id, filename)
);
COMMENT ON TABLE filesarticles IS
	'Archivos relacionados a los artículos';
COMMENT ON COLUMN filesarticles.article_id IS
	'ID del artículo referenciado';
COMMENT ON COLUMN filesarticles.content IS
	'Contenido (binario) del archivo';



------
-- Update articleslog if there was a status change
------
CREATE OR REPLACE FUNCTION articles_update() RETURNS TRIGGER 
SECURITY DEFINER AS '
DECLARE 
BEGIN
	IF OLD.artstatus_id = NEW.artstatus_id THEN
		RETURN NEW;
	END IF;
	INSERT INTO articleslog (articles_id, old_artstatus_id, moduser_id)
		VALUES (OLD.id, OLD.artstatus_id, OLD.moduser_id);
        RETURN NEW;
END;
' LANGUAGE 'plpgsql';

CREATE TRIGGER articles_update BEFORE DELETE ON articles
	FOR EACH ROW EXECUTE PROCEDURE articles_update();
