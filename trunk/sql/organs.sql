-- Organos Colegiados 
-- Organos editoriales
-- Otro
CREATE TABLE organtype (
	id serial,
	name text NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);

---- Organos Colegiados ----
-- Presidente, propietario, suplente, vocal, representante, miembro, 
-- secretario
---- Organos editoriales ----
-- Director de revista, director de colección, miembro de comité editorial,
-- secretario de redacción
CREATE TABLE roleinorgan (
	id serial,
	name text NOT NULL,
	moduser_id int4 NOT NULL    	     -- Use it only to know who has
	    REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
	dbuser text DEFAULT CURRENT_USER,
	dbtimestamp timestamp DEFAULT now(),
	PRIMARY KEY (id),
	UNIQUE (name)
);

---- Organos Colegiados ----
-- Junta de gobierno
-- Consejo universitario
-- Consejo técnico
-- Consejo académico de área
-- Consejo interno
-- Comité académico
-- Comité de becas
-- Comisiones evaluadoras
-- Comisiones dictaminadoras
-- Otro
---- Organos editoriales ----
-- ..
CREATE TABLE organ (
	id serial,
	name text NOT NULL,
	abbrev text NULL,
	organtype_id int4 NOT NULL
	    REFERENCES organtype(id)
            ON UPDATE CASCADE  
            DEFERRABLE,
	institution_id int4 NOT NULL
	    REFERENCES institutions(id)
            ON UPDATE CASCADE  
            DEFERRABLE,
	moduser_id int4 NOT NULL    	     -- Use it only to know who has
	    REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
	dbuser text DEFAULT CURRENT_USER,
	dbtimestamp timestamp DEFAULT now(),
	PRIMARY KEY (id),
	UNIQUE (name),
	UNIQUE (abbrev)
);


CREATE TABLE userorgan (
	id SERIAL,
	uid int4 NOT NULL
	    REFERENCES users(id)
            ON UPDATE CASCADE  
            ON DELETE CASCADE  
            DEFERRABLE,
	organ_id int4 NOT NULL
	    REFERENCES organ(id)
            ON UPDATE CASCADE   
            DEFERRABLE,
	roleinorgan_id int4 NOT NULL
	    REFERENCES roleinorgan(id)
            ON UPDATE CASCADE   
            DEFERRABLE,
	startyear int4 NOT NULL,
	startmonth int4 NULL CHECK (startmonth >= 1 AND startmonth <= 12),
	endyear int4  NULL,
	endmonth int4 NULL CHECK (endmonth >= 1 AND endmonth <= 12),
	PRIMARY KEY(id),
	CONSTRAINT valid_duration CHECK (endyear IS NULL OR
		(startyear * 12 + coalesce(startmonth,0)) > (endyear * 12 + coalesce(endmonth,0)))	
);