----------------------------------------
-- Conferences Information            --
----------------------------------------
CREATE TABLE attendeetypes ( 
        id SERIAL,
        name text NOT NULL, 
        PRIMARY KEY(id),
	UNIQUE (name)
);
COMMENT ON TABLE attendeetypes IS
	'Rol de un usuario en un congreso:
	Asistente, ponente, organizador, instructor, coordinador general, 
	coordinador de mesa, comité académico, comité técnico, moderador de mesa,
	relator de mesa, relator general, ...';

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
    conferencescope_id smallint NOT NULL 
                         REFERENCES conferencescopes(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
    location text NULL,
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
	'Usuarios que asistieron a un congreso (su rol aparece en 
	userconferencerole)';

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
    name text NOT NULL,
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
    UNIQUE (conference_id, name, authors),
    PRIMARY KEY (id)    
);
COMMENT ON TABLE conferencetalks IS
	'Las pláticas que forman parte de un congreso';
COMMENT ON COLUMN conferencetalks.authors IS
	'Listado de autores tal cual aparece en la ponencia - La 
	relación entre usuarios y ponencias es independiente de esta, ver 
	userconferencerole.';

CREATE TABLE user_conferenceroles (
    id SERIAL,
    userconference_id integer NOT NULL 
	    REFERENCES userconferences(id)
	    ON UPDATE CASCADE
	    ON DELETE CASCADE
	    DEFERRABLE,
    attendeetype_id int4 NOT NULL 
            REFERENCES attendeetypes(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    conferencetalk_id integer NULL
	    REFERENCES conferencetalks(id)
	    ON UPDATE CASCADE
	    ON DELETE CASCADE
	    DEFERRABLE,
    comment text NULL,
    moduser_id int4 NOT NULL                 -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (userconference_id, attendeetype_id, conferencetalk_id)
);
COMMENT ON TABLE user_conferenceroles IS
	'Tipo de participación de un usuario en un congreso - Si sólamente 
	fue como asistente, no requiere ningún registro en esta tabla.';
COMMENT ON COLUMN user_conferenceroles.conferencetalk_id IS
	'Si el usuario fue ponente, indicará aquí el ID de su ponencia. Si es
	organizador, este campo debe quedar nulo.';
