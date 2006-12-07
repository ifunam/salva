----------------------------------------
-- Conferences Information            --
----------------------------------------
CREATE TABLE conferencetypes ( 
        id SERIAL,
        name text NOT NULL,
        PRIMARY KEY(id),
	UNIQUE (name)
);
COMMENT ON TABLE conferencetypes IS
	'Tipos de congreso:
	Congreso, seminario, coloquio, encuentro, homenaje, jornadas, mesa redonda,
	simposio, taller';

CREATE TABLE conferencescopes ( 
        id SERIAL,
        name text NOT NULL,
        PRIMARY KEY(id),
	UNIQUE (name)
);
COMMENT ON TABLE conferencescopes IS 
	'Ámbito del congreso:
	Local, Nacional, Internacional, ...';

CREATE TABLE talktypes ( 
        id SERIAL,
        name text NOT NULL,
        PRIMARY KEY(id),
	UNIQUE (name)
);
COMMENT ON TABLE talktypes IS
	'Tipo de ponencia:
	Conferencia, plática, tutorial, taller, magistral, poster, ...';

CREATE TABLE conferences ( 
    id SERIAL,
    name text NOT NULL,
    url text NULL,
    month int4 NULL CHECK (month >= 1 AND month <= 12),
    year  int4 NOT NULL,
    conferencetype_id integer NOT NULL
                         REFERENCES conferencetypes(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
    country_id smallint NOT NULL 
                         REFERENCES countries(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
    conferencescope_id smallint NULL 
                         REFERENCES conferencescopes(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
    location text NULL,
    istechnical BOOLEAN NOT NULL default 'f',
    moduser_id int4 NOT NULL                 -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (name, year, country_id)
);
COMMENT ON TABLE conferences IS
	'Congresos';
COMMENT ON COLUMN conferences.location IS
	'En qué parte/región del país es este congreso';

CREATE TABLE conference_institutions (
    id SERIAL,
    conference_id int4 NOT NULL
            REFERENCES conferences(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    institution_id int4 NOT NULL 
            REFERENCES institutions(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    moduser_id int4 NOT NULL                 -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (conference_id,  institution_id)
);
COMMENT ON TABLE conference_institutions IS
	'Instituciones que organizan este congreso';

CREATE TABLE roleinconferences ( 
        id SERIAL,
        name text NOT NULL, 
        PRIMARY KEY(id),
	UNIQUE (name)
);

CREATE TABLE userconferences ( 
    id SERIAL,
    conference_id int4 NOT NULL 
            REFERENCES conferences(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    user_id int4 NOT NULL 
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    roleinconference_id int4 NOT NULL 
            REFERENCES roleinconferences(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    moduser_id int4 NOT NULL                 -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id, conference_id),
    PRIMARY KEY (id)
);
COMMENT ON TABLE userconferences IS
	'Usuarios que asistieron a un congreso (su rol aparece en roleinconferences)';

CREATE TABLE talkacceptances (
       id SERIAL,
        name text NOT NULL,
        PRIMARY KEY(id),
	UNIQUE (name)
);
COMMENT ON TABLE talkacceptances IS
	'Cómo fue la inscripción/aceptación de la ponencia en el congreso?:
	Invitado, Arbitrado, Inscrito, ....';

CREATE TABLE conferencetalks (
    id SERIAL,
    title text NOT NULL,
    authors text NOT NULL,
    abstract text NULL,
    conference_id integer NOT NULL
            REFERENCES conferences(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    talktype_id integer NOT NULL
            REFERENCES talktypes(id)      
            ON UPDATE CASCADE
            DEFERRABLE,
    talkacceptance_id integer NOT NULL
            REFERENCES talkacceptances(id)      
            ON UPDATE CASCADE
            DEFERRABLE,
    modality_id int4 NOT NULL 
            REFERENCES modalities(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    moduser_id int4 NOT NULL                 -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (conference_id, title, authors),
    PRIMARY KEY (id)    
);
COMMENT ON TABLE conferencetalks IS
	'Las pláticas que forman parte de un congreso';
COMMENT ON COLUMN conferencetalks.authors IS
	'Listado de autores tal cual aparece en la ponencia - La 
	relación entre usuarios y ponencias es independiente de esta, ver 
	userconferencerole.';

CREATE TABLE roleinconferencetalks ( 
        id SERIAL,
        name text NOT NULL, 
        PRIMARY KEY(id),
	UNIQUE (name)
);
COMMENT ON TABLE roleinconferencetalks IS
	'Rol de un usuario en un congreso: Ponente, instructor c
	Asistente, ponente, instructor, coordinador de mesa, moderador de mesa, elator de mesa, relator general, ...';


CREATE TABLE user_conferencetalks (
    id SERIAL,
    user_id integer NOT NULL 
	    REFERENCES users(id)
	    ON UPDATE CASCADE
	    ON DELETE CASCADE
	    DEFERRABLE,
    conferencetalk_id integer NULL
	    REFERENCES conferencetalks(id)
	    ON UPDATE CASCADE
	    ON DELETE CASCADE
	    DEFERRABLE,
    roleinconferencetalk_id int4 NOT NULL 
            REFERENCES roleinconferencetalks(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    comment text NULL,
    moduser_id int4 NOT NULL                 -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (user_id, roleinconferencetalk_id, conferencetalk_id)
);
COMMENT ON TABLE user_conferencetalks IS
	'Tipo de participación de un usuario en un congreso - Si sólamente 
	fue como asistente, no requiere ningún registro en esta tabla.';
COMMENT ON COLUMN user_conferencetalks.conferencetalk_id IS
	'Si el usuario fue ponente, indicará aquí el ID de su ponencia. Si es
	organizador, este campo debe quedar nulo.';

CREATE TABLE proceedings (
	id SERIAL,
	conference_id int4 NOT NULL 
            REFERENCES conferences(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
	title text NULL,
	year int4 NULL,
        publisher_id int4 NULL 
	    REFERENCES publishers(id)
            ON UPDATE CASCADE
            DEFERRABLE,
	isrefereed BOOLEAN NOT NULL default 't',
	other text NULL,	
	moduser_id int4 NOT NULL                 -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
    	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    	UNIQUE (conference_id,title),
    	PRIMARY KEY (id)
);

CREATE table roleproceedings (
	id serial,
	name text NOT NULL,
	moduser_id int4 NULL               	    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id),
	UNIQUE (name)	
);

CREATE TABLE user_proceedings (
   id SERIAL,
   proceeding_id int4 NOT NULL 
            REFERENCES proceedings(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   user_id integer 
            REFERENCES users(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
   roleproceeding_id integer NOT NULL 
            REFERENCES roleproceedings(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   comment text NULL,	
   moduser_id int4 NULL               	    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
   created_on timestamp DEFAULT CURRENT_TIMESTAMP,
   updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (id),
   UNIQUE (proceeding_id, user_id, roleproceeding_id)  -- Un usuario podría tener más de un rol
);
COMMENT ON TABLE user_proceedings IS 
	'Rol de cada uno de los usuarios involucrados en memorias';

CREATE TABLE inproceedings (
	id SERIAL,
	proceeding_id int4 NOT NULL 
            REFERENCES proceedings(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
	title text NOT NULL,
	authors text NOT NULL,
	pages text NULL,
	comment text NULL,
	moduser_id int4 NOT NULL                 -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
    	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    	UNIQUE (proceeding_id, title),
    	PRIMARY KEY (id)
);


CREATE TABLE user_inproceedings (
   id SERIAL,
   inproceeding_id int4 NOT NULL 
            REFERENCES inproceedings(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   user_id integer 
            REFERENCES users(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
   ismainauthor BOOLEAN NOT NULL default 't',	
   moduser_id int4 NULL               	    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
   created_on timestamp DEFAULT CURRENT_TIMESTAMP,
   updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (id),
   UNIQUE (inproceeding_id, user_id)  -- Un usuario podría tener más de un rol
);
COMMENT ON TABLE user_inproceedings IS 
	'Rol de cada uno de los usuarios involucrados en un articulo en memorias';
