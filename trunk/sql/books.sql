-------------
--  Books  --
-------------

CREATE TABLE roleinbooks (
	id serial,
	name text NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE roleinbooks IS
	'El rol que un usuario tiene en un libro';
-- Autor, coautor, revisor, traductor, editor, compilador, coordinador

CREATE TABLE bookstype (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY(id),
	UNIQUE (name)
);
COMMENT ON TABLE bookstype IS
	'Tipo de libro - Único, serie, colección, etc.';
-- Único, serie, colección, libro arbitrado, etc.

CREATE TABLE books ( 
    id SERIAL,
    title   text NOT NULL,
    author text NOT NULL,
    coauthors text NULL,
    booklink text  NULL,
    country_id int4 NOT NULL 
                 REFERENCES countries(id)
                 ON UPDATE CASCADE
                 DEFERRABLE,
    bookstype_id int4 NOT NULL
            REFERENCES bookstype(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    origlanguages_id  int4 NULL  
        	REFERENCES languages(id)
            	ON UPDATE CASCADE
		DEFERRABLE,
    translanguages_id int4 NULL  
        	REFERENCES languages(id)
            	ON UPDATE CASCADE
		DEFERRABLE,
    numcites int4 NULL CHECK (numcites >= 0),
    moduser_id int4 NULL                    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
    PRIMARY KEY (id)
);
COMMENT ON TABLE books IS
	'Los libros que maneje el sistema';
COMMENT ON COLUMN books.author IS 'Nombre del autor principal del libro 
	(no es referencia, muchas veces no será usuario del sistema. Ver 
	tabla userbooks)';
COMMENT ON COLUMN books.coauthors IS 'Nombre de los coautores del libro 
	(no es referencia, muchas veces no será usuario del sistema. Ver 
	tabla userbooks)';

CREATE TABLE volumes (
	id serial,
	name text NOT NULL,
	PRIMARY KEY(id),
	UNIQUE(name)
);
COMMENT ON TABLE volumes IS
	'Volúmenes (normalmente numerados) de libros';
-- I, II, III, ...

CREATE TABLE booksvolumes (
        volumes_id int4 NOT NULL
	        REFERENCES volumes(id)
        	ON UPDATE CASCADE 
	        DEFERRABLE,
        books_id int4 NOT NULL 
	        REFERENCES books(id) 
        	ON UPDATE CASCADE
	        DEFERRABLE,
	title text NOT NULL,
	PRIMARY KEY (volumes_id,books_id)
);
COMMENT ON TABLE booksvolumes IS
	'Representa a los libros que se agrupan como volúmenes de una obra';

-- NOTA: Agregar constraint para que si varios libro pertenecen a una 
-- colección obligue a que todos sean del mismo publisher

CREATE TABLE editions (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY(id),
	UNIQUE(name)
);
COMMENT ON TABLE editions IS
	'Ediciones (normalmente numeradas) de libros';
-- Primera, segunda, tercera, ..., especial, ...

CREATE TABLE bookseditionsstatus (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY(id),
	UNIQUE(name)
);
COMMENT ON TABLE bookseditionsstatus IS
	'Estado de una edición de un libro';
-- Publicado, en prensa, aceptado para publicación, en dictámen/en evaluación

CREATE TABLE bookseditions ( --
    id serial,
    books_id int4 NOT NULL 
            REFERENCES books(id)
            ON UPDATE CASCADE   
            DEFERRABLE,
    editions_id int4 NOT NULL 
            REFERENCES editions(id)
            ON UPDATE CASCADE 
            DEFERRABLE,
    pages int4 NULL,     -- Number of pages
    isbn  text NULL,     -- ISBN
    publisher_id int4 NULL 
	    REFERENCES publishers(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    mediatype_id int4 NOT NULL 
	    REFERENCES mediatype(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    bookseditionsstatus_id int4 NULL 
	    REFERENCES bookseditionsstatus(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    month int4 NULL CHECK (month >= 1 AND month <= 12),
    year  int4 NULL,       -- Edition year
    other text NULL,        -- Which URL / where can you find it / whatever
    moduser_id int4 NULL           -- Use it to known who
            REFERENCES users(id)   -- has inserted, updated or deleted
            ON UPDATE CASCADE      -- data into or  from this table.
            DEFERRABLE,
    PRIMARY KEY (id),
    UNIQUE (books_id, editions_id, bookseditionsstatus_id)
);
COMMENT ON TABLE bookseditions IS
	'Historial de las ediciones de un libro - En qué edición va? Cuándo 
	fue impresa? Cuál es el estado de cada una de ellas?';

-- Does this book edition have more than one publisher?
CREATE TABLE bookseditionscopublisher (
    id serial,
    bookseditions_id int4 NOT NULL
	    REFERENCES bookseditions(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    publisher_id int4 NULL 
	    REFERENCES publishers(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    PRIMARY KEY(id),
    UNIQUE (bookseditions_id, publisher_id)
);
COMMENT ON TABLE bookseditionscopublisher IS
	'Para las ediciones que tengan más de una editorial (la principal 
	está ya en bookseditions.publisher_id';

CREATE TABLE userbooks ( 
    id SERIAL,
    uid int4 NOT NULL 
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    books_id int4 NOT NULL 
            REFERENCES books(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    roleinbooks_id int4 NOT NULL 
            REFERENCES roleinbooks(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    year int4 NOT NULL,
    other text NULL,
    PRIMARY KEY (uid, books_id)
);
COMMENT ON TABLE userbooks IS 
	'El rol de cada uno de los usuarios que participaron en un libro';

CREATE table chaptersbooks (
   id SERIAL,
   books_id int4 NOT NULL 
            REFERENCES books(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   chapter text NOT NULL,
   pages   text NULL,
   year    int4 NOT NULL,
   numcites int4 NULL CHECK (numcites >= 0),
   moduser_id int4 NULL      -- Use it to known who
            REFERENCES users(id) -- has inserted, updated or deleted
            ON UPDATE CASCADE    -- data into or from this table.
            DEFERRABLE,
   PRIMARY KEY (id),
  UNIQUE (books_id, chapter)
);
CREATE INDEX chaptersbooks_chapter_idx ON chaptersbooks(chapter);
CREATE INDEX chaptersbooks_chapter_year_idx ON chaptersbooks(chapter,year);
COMMENT ON TABLE chaptersbooks IS
	'Capítulos en un libro (cuando son reportados por separado)';
COMMENT ON COLUMN chaptersbooks.chapter IS
	'Nombre del capítulo';

CREATE TABLE userchaptersbooks ( 
    id SERIAL,
    uid int4 NOT NULL 
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    chaptersbooks_id int4 NOT NULL
            REFERENCES chaptersbooks(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    roleinbooks_id int4 NOT NULL 
            REFERENCES roleinbooks(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    year int4 NOT NULL,
    other text NULL,
    PRIMARY KEY (uid, chaptersbooks_id)
);
COMMENT ON TABLE userchaptersbooks IS 
	'El rol de cada uno de los usuarios que participaron en un capítulo
	de libro';
