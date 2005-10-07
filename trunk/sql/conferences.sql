----------------------------------------
-- Conferences Information            --
----------------------------------------
CREATE TABLE attendeetype ( 
        id SERIAL,
        name text NOT NULL, 
        PRIMARY KEY(id),
	UNIQUE (name)
);
COMMENT ON TABLE attendeetype IS
	'Rol de un usuario en un congreso';
-- Asistente, ponente, organizador, instructor, coordinador general, 
-- coordinador de mesa, comité académico, comité técnico, moderador de mesa,
-- relator de mesa, relator general

CREATE TABLE conferencetypes ( 
        id SERIAL,
        name text NOT NULL,
        PRIMARY KEY(id),
	UNIQUE (name)
);
COMMENT ON TABLE conferencetypes IS
	'Tipos de congreso';
-- Congreso, seminario, coloquio, encuentro, homenaje, jornadas, mesa redonda,
-- simposio, taller

CREATE TABLE conferencescope ( 
        id SERIAL,
        name text NOT NULL,
        PRIMARY KEY(id),
	UNIQUE (name)
);
COMMENT ON TABLE conferencescope IS 
	'Ámbito del congreso';
-- Local, Nacional, Internacional, ...

CREATE TABLE talktype ( 
        id SERIAL,
        name text NOT NULL,
        PRIMARY KEY(id),
	UNIQUE (name)
);
COMMENT ON TABLE talktype IS
	'Tipo de ponencia';
-- Conferencia, plática, tutorial, taller, magistral, poster, ...

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
                         REFERENCES conferencescope(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
    location text NULL,
    uid int4 NOT NULL                        -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
    PRIMARY KEY (id),
    UNIQUE (name, year, country_id)
);
COMMENT ON TABLE conferences IS
	'Congresos';
COMMENT ON COLUMN conferences.location IS
	'En qué parte/región del país es este congreso';

CREATE TABLE conferenceinstitutions ( 
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
    PRIMARY KEY (institution_id, conference_id)
);
COMMENT ON TABLE conferenceinstitutions IS
	'Instituciones que organizan este congreso';

CREATE TABLE userconferences ( 
    id SERIAL,
    conference_id int4 NOT NULL 
            REFERENCES conferences(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    uid int4 NOT NULL 
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    UNIQUE (uid, conference_id),
    PRIMARY KEY (id)
);
COMMENT ON TABLE userconferences IS
	'Usuarios que asistieron a un congreso (su rol aparece en 
	userconferencerole)';

CREATE TABLE talkacceptance (
       id SERIAL,
        name text NOT NULL,
        PRIMARY KEY(id),
	UNIQUE (name)
);
COMMENT ON TABLE talkacceptance IS
	'Cómo fue la inscripción/aceptación de la ponencia en el congreso?';
-- Invitado, Arbitrado, Inscrito, ....

CREATE TABLE conferencetalks (
    id SERIAL,
    conference_id integer NOT NULL
            REFERENCES conferences(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    talktype_id integer NOT NULL
            REFERENCES talktype(id)      
            ON UPDATE CASCADE
            DEFERRABLE,
    talkacceptance_id integer NOT NULL
            REFERENCES talkacceptance(id)      
            ON UPDATE CASCADE
            DEFERRABLE,
    modality_id int4 NOT NULL 
            REFERENCES modality(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    title text NOT NULL,
    authors text NOT NULL,
    abstract text NULL,
    UNIQUE (conference_id, title, authors),
    PRIMARY KEY (id)    
);
COMMENT ON TABLE conferencetalks IS
	'Las pláticas que forman parte de un congreso';
COMMENT ON COLUMN articles.authors IS
	'Listado de autores tal cual aparece en la ponencia - La 
	relación entre usuarios y ponencias es independiente de esta, ver 
	userconferencerole.';

CREATE TABLE userconferencerole (
    id SERIAL,
    userconference_id integer NOT NULL 
	    REFERENCES userconferences(id)
	    ON UPDATE CASCADE
	    ON DELETE CASCADE
	    DEFERRABLE,
    attendeetype_id int4 NOT NULL 
            REFERENCES attendeetype(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    conferencetalk_id integer NULL
	    REFERENCES conferencetalks(id)
	    ON UPDATE CASCADE
	    ON DELETE CASCADE
	    DEFERRABLE,
    comments text NULL,
    PRIMARY KEY (id),
    UNIQUE (userconference_id, attendeetype_id, conferencetalk_id)
);
COMMENT ON TABLE userconferencerole IS
	'Tipo de participación de un usuario en un congreso - Si sólamente 
	fue como asistente, no requiere ningún registro en esta tabla.';
COMMENT ON COLUMN userconferencerole.conferencetalk_id IS
	'Si el usuario fue ponente, indicará aquí el ID de su ponencia. Si es
	organizador, este campo debe quedar nulo.';
