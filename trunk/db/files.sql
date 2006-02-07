-- Files stored in the system

CREATE TABLE articlesfiles (
	id serial NOT NULL,
	filename text NOT NULL,
	articles_id int4 NOT NULL
		REFERENCES articles(id)
		ON UPDATE CASCADE
		ON DELETE CASCADE
		DEFERRABLE,
	filedescr text NULL,
	content bytea NOT NULL,
	creationtime timestamp NOT NULL DEFAULT now(),
	lastmodiftime timestamp NOT NULL DEFAULT now(),
	moduser_id int4 NULL         -- It will be used only to know who has
		REFERENCES users(id) -- inserted, updated or deleted  
		ON UPDATE CASCADE    -- data into or from this table.
		DEFERRABLE,
	dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE (articles_id, filename)
);
CREATE INDEX articlesfiles_filename_idx ON articlesfiles(filename);
CREATE INDEX articlesfiles_articles_idx ON articlesfiles(articles_id);
COMMENT ON TABLE articlesfiles IS
	'Archivos relacionados a un artículo';
COMMENT ON COLUMN articlesfiles.content IS
	'Contenido (binario) del archivo';

CREATE TABLE booksfiles (
	id serial NOT NULL,
	filename text NOT NULL,
	books_id int4 NOT NULL
		REFERENCES books(id)
		ON UPDATE CASCADE
		ON DELETE CASCADE
		DEFERRABLE,
	filedescr text NULL,
	content bytea NOT NULL,
	creationtime timestamp NOT NULL DEFAULT now(),
	lastmodiftime timestamp NOT NULL DEFAULT now(),
	moduser_id int4 NULL         -- It will be used only to know who has
		REFERENCES users(id) -- inserted, updated or deleted  
		ON UPDATE CASCADE    -- data into or from this table.
		DEFERRABLE,
	dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE (books_id, filename)
);
CREATE INDEX booksfiles_filename_idx ON booksfiles(filename);
CREATE INDEX booksfiles_books_idx ON booksfiles(books_id);
COMMENT ON TABLE articlesfiles IS
	'Archivos relacionados a un libro';
COMMENT ON COLUMN articlesfiles.content IS
	'Contenido (binario) del archivo';

CREATE TABLE chapterinbooksfiles (
	id serial NOT NULL,
	filename text NOT NULL,
	chapterinbook_id int4 NOT NULL
		REFERENCES chapterinbooks(id)
		ON UPDATE CASCADE
		ON DELETE CASCADE
		DEFERRABLE,
	filedescr text NULL,
	content bytea NOT NULL,
	creationtime timestamp NOT NULL DEFAULT now(),
	lastmodiftime timestamp NOT NULL DEFAULT now(),
	moduser_id int4 NULL         -- It will be used only to know who has
		REFERENCES users(id) -- inserted, updated or deleted  
		ON UPDATE CASCADE    -- data into or from this table.
		DEFERRABLE,
	dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE (chapterinbook_id, filename)
);
CREATE INDEX chapterinbooksfiles_filename_idx ON chapterinbooksfiles(filename);
CREATE INDEX chapterinbooksfiles_chapterinbooks_idx ON
	chapterinbooksfiles(chapterinbook_id);
COMMENT ON TABLE chapterinbooksfiles IS
	'Archivos relacionados a un capítulo de libro';
COMMENT ON COLUMN chapterinbooksfiles.content IS
	'Contenido (binario) del archivo';

CREATE TABLE conferencetalksfiles (
	id serial NOT NULL,
	filename text NOT NULL,
	conferencetalks_id int4 NOT NULL
		REFERENCES conferencetalks(id)
		ON UPDATE CASCADE
		ON DELETE CASCADE
		DEFERRABLE,
	filedescr text NULL,
	content bytea NOT NULL,
	creationtime timestamp NOT NULL DEFAULT now(),
	lastmodiftime timestamp NOT NULL DEFAULT now(),
	moduser_id int4 NULL         -- It will be used only to know who has
		REFERENCES users(id) -- inserted, updated or deleted  
		ON UPDATE CASCADE    -- data into or from this table.
		DEFERRABLE,
	dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE (conferencetalks_id, filename)
);
CREATE INDEX conferencetalksfiles_filename_idx ON 
	conferencetalksfiles(filename);
CREATE INDEX conferencetalksfiles_conferencetalks_idx ON 
	conferencetalksfiles(conferencetalks_id);
COMMENT ON TABLE conferencetalksfiles IS
	'Archivos relacionados a una conferencia';
COMMENT ON COLUMN conferencetalksfiles.content IS
	'Contenido (binario) del archivo';

CREATE TABLE genericworksfiles (
	id serial NOT NULL,
	filename text NOT NULL,
	genericworks_id int4 NOT NULL
		REFERENCES genericworks(id)
		ON UPDATE CASCADE
		ON DELETE CASCADE
		DEFERRABLE,
	filedescr text NULL,
	content bytea NOT NULL,
	creationtime timestamp NOT NULL DEFAULT now(),
	lastmodiftime timestamp NOT NULL DEFAULT now(),
	moduser_id int4 NULL         -- It will be used only to know who has
		REFERENCES users(id) -- inserted, updated or deleted  
		ON UPDATE CASCADE    -- data into or from this table.
		DEFERRABLE,
	dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE (genericworks_id, filename)
);
CREATE INDEX genericworksfiles_filename_idx ON genericworksfiles(filename);
CREATE INDEX genericworksfiles_genericworks_idx ON 
	genericworksfiles(genericworks_id);
COMMENT ON TABLE genericworksfiles IS
	'Archivos relacionados a un trabajo genérico';
COMMENT ON COLUMN genericworksfiles.content IS
	'Contenido (binario) del archivo';
