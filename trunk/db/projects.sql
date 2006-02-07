-----------------------
-- Research Projects -- 
-----------------------

-- Estas tablas dependen de la existencia de las de conferences.sql.

CREATE TABLE projectstype (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE projectstype IS
	'Tipos de proyectos';
-- Investigación, Apoyo, Infraestructura, Otro.

CREATE TABLE projectstatus (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE projectstatus IS
	'Estado de los proyectos';
-- En desarrollo, planeación, terminado,

CREATE TABLE projects ( 
    id SERIAL,   
    title   text NOT NULL,
    description text NOT NULL,
    projectstype_id integer NOT NULL
	    REFERENCES projectstype(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    projectstatus_id integer NOT NULL
	    REFERENCES projectstatus(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    parentproject_id integer NULL
	    REFERENCES projects(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    subject  text NULL,
    summary  text NULL, 
    abbrev   text NULL,
    goals   text NULL, 
    notes   text NULL,
    startyear int4 NOT NULL,
    startmonth int4 NULL CHECK (startmonth >= 1 AND startmonth <= 12),
    endyear int4  NULL,
    endmonth int4 NULL CHECK (endmonth >= 1 AND endmonth <= 12),
    url	     text NULL,
    other    text NULL,
    moduser_id int4 NULL  -- Use it only to know who has
               REFERENCES users(id)             -- inserted, update or delete  
               ON UPDATE CASCADE                -- data into or from this table.
               DEFERRABLE,
    PRIMARY KEY(id),
    UNIQUE (title),
    CONSTRAINT valid_duration CHECK (endyear IS NULL OR
	       (startyear * 12 + coalesce(startmonth,0)) > (endyear * 12 + coalesce(endmonth,0)))
);
CREATE INDEX projects_title_idx ON projects(title);
CREATE INDEX projects_description_idx ON projects(description);
COMMENT ON TABLE projects IS
	'Datos generales de cada uno de los proyectos';
COMMENT ON COLUMN projects.parentproject_id IS
	'Para implementar sub-proyectos, relacionamos con un proyecto padre';
COMMENT ON COLUMN projects.subject IS
	'Temática, tema (no confundir con title)';
COMMENT ON COLUMN projects.abbrev IS
	'Acrónimo';
COMMENT ON COLUMN projects.notes IS
	'Logros y avances';

CREATE TABLE projectinstitutions (
    id SERIAL,
    project_id integer NOT NULL 
	    REFERENCES projects(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    institution_id integer NOT NULL 
	    REFERENCES institutions(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    other text NULL,
    PRIMARY KEY (id),
    UNIQUE (project_id, institution_id)
);
COMMENT ON TABLE projectinstitutions IS
	'Relación de cada proyecto con las instituciones relacionadas';

CREATE TABLE projectresearchlines (
    id SERIAL,
    project_id integer NOT NULL 
	    REFERENCES projects(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    researchlines_id integer NOT NULL 
	    REFERENCES researchlines(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    other text NULL,
    PRIMARY KEY (id),
    UNIQUE (project_id, researchlines_id)
);
COMMENT ON TABLE projectresearchlines IS
	'Relación de cada proyecto con las líneas de investigación';

CREATE TABLE projectresearchareas (
    id SERIAL,
    project_id integer NOT NULL 
	    REFERENCES projects(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    researchareas_id integer NOT NULL 
	    REFERENCES researchareas(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    other text NULL,
    PRIMARY KEY (id),
    UNIQUE (project_id, researchareas_id)
);
COMMENT ON TABLE projectresearchareas IS
	'Relación de cada proyecto con las líneas de investigación';

CREATE TABLE filesprojects (
   id serial NOT NULL,
   project_id int4 NOT NULL
            REFERENCES projects(id)
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
    UNIQUE (project_id, filename)
);
COMMENT ON TABLE filesprojects IS
	'Archivos relacionados a los proyectos';
COMMENT ON COLUMN filesprojects.project_id IS
	'ID del proyect referenciado';
COMMENT ON COLUMN filesprojects.content IS
	'Contenido (binario) del archivo';

CREATE TABLE projectfinancingsource (
    id SERIAL,
    project_id integer NOT NULL 
	    REFERENCES projects(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    financingsource_id integer NOT NULL 
	    REFERENCES institutions(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    amount integer NOT NULL,
    other text NULL,
    PRIMARY KEY (id),
    UNIQUE (project_id, financingsource_id )
);
COMMENT ON TABLE projectfinancingsource IS
	'Fuentes de financiamiento (instituciones) de cada proyecto';

CREATE TABLE roleinproject (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY (id),
	UNIQUE(name)
);
COMMENT ON TABLE roleinproject IS
	'Roles en un proyecto';
-- Responsable, corresponsable, participante, apoyo a la investigación (T.A.),
-- becario; etc.

CREATE TABLE userprojects (
   id SERIAL,
   projects_id integer NOT NULL 
            REFERENCES projects(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   user_is_internal bool, 
   externaluser_id integer 
            REFERENCES externalusers(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
   internaluser_id integer 
             REFERENCES users(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
   roleinproject_id integer NOT NULL 
            REFERENCES roleinproject(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   PRIMARY KEY (id),
   UNIQUE (projects_id, internaluser_id ),
   UNIQUE (projects_id, externaluser_id ),
   -- Sanity checks: If this is a full system user, require the user
   -- to be filled in. Likewise for an external one.
   CHECK (user_is_internal = 't' OR
	(internaluser_id IS NOT NULL AND externaluser_id IS NULL)),
   CHECK (user_is_internal = 'f' OR
	(externaluser_id IS NOT NULL AND internaluser_id IS NULL))
);
COMMENT ON TABLE userprojects IS
	'Relación entre usuarios (internos/externos) y proyectos';
COMMENT ON COLUMN userprojects.user_is_internal IS
	'El usuario es interno del sistema? Si sí, exigimos internaluser_id; 
	si no, exigimos externaluser_id';

CREATE TABLE projectsarticles (
	project_id integer NOT NULL 
	    REFERENCES projects(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
	article_id integer NOT NULL 
	    REFERENCES articles(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
	PRIMARY KEY (project_id, article_id)
);
COMMENT ON TABLE projectsarticles IS
	'Artículos relacionados con cada proyecto';

CREATE TABLE projectsthesis (
	project_id integer NOT NULL 
	    REFERENCES projects(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
	thesis_id integer NOT NULL 
	    REFERENCES thesis(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
	PRIMARY KEY (project_id, thesis_id)
);
COMMENT ON TABLE projectsthesis IS
	'Artículos relacionados con cada proyecto';

CREATE TABLE projectsbooks (
	project_id integer NOT NULL 
	    REFERENCES projects(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
	books_id integer NOT NULL 
	    REFERENCES books(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
	PRIMARY KEY (project_id, books_id)
);
COMMENT ON TABLE projectsbooks IS
	'Libros relacionados con cada proyecto';

CREATE TABLE projectschapterinbooks (
	project_id integer NOT NULL 
	    REFERENCES projects(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
	chapterinbook_id integer NOT NULL 
	    REFERENCES chapterinbooks(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
	PRIMARY KEY (project_id, chapterinbook_id)
);
COMMENT ON TABLE projectschapterinbooks IS
	'Capítulos en libro relacionados con cada proyecto';

CREATE TABLE projectsconferencetalks (
	project_id integer NOT NULL 
	    REFERENCES projects(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
	conferencetalks_id integer NOT NULL 
	    REFERENCES conferencetalks(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
	PRIMARY KEY (project_id, conferencetalks_id)
);
COMMENT ON TABLE projectsconferencetalks IS
	'Ponencias en congreso relacionadas con cada proyecto';

CREATE TABLE projectsacadvisits (
	project_id integer NOT NULL 
	    REFERENCES projects(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
	acadvisits_id integer NOT NULL 
	    REFERENCES acadvisits(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
	PRIMARY KEY (project_id, acadvisits_id)
);
COMMENT ON TABLE projectsacadvisits IS
	'Estancias académicas relacionadas con cada proyecto';

CREATE TABLE projectsgenericworks (
	project_id integer NOT NULL 
	    REFERENCES projects(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
	genericworks_id integer NOT NULL 
	    REFERENCES genericworks(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
	PRIMARY KEY (project_id, genericworks_id)
);
COMMENT ON TABLE projectsgenericworks IS
	'Trabajos genéricos relacionados con cada proyecto';

CREATE TABLE projectslog (
    id SERIAL,
    project_id integer NOT NULL
            REFERENCES projects(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    old_projectstatus_id integer  NOT NULL 
	    REFERENCES projectstatus(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    year int4 NOT NULL,
    month int4 NULL CHECK (month >= 1 AND month <= 12),
    moduser_id integer NULL      -- It will be used only to know who has
            REFERENCES users(id) -- inserted, updated or deleted  
            ON UPDATE CASCADE    -- data into or from this table.
            DEFERRABLE,
    dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
COMMENT ON TABLE projectslog IS 
	'Bitácora de cambios de estado en proyectos';

------
-- Update projectslog if there was a status change
------
CREATE OR REPLACE FUNCTION projects_update() RETURNS TRIGGER 
SECURITY DEFINER AS '
DECLARE 
BEGIN
 	IF OLD.projectstatus_id = NEW.projectstatus_id THEN
		RETURN NEW;
	END IF;
	INSERT INTO projectslog (project_id, old_projectstatus_id, moduser_id) 
		VALUES (OLD.id, OLD.projectstatus_id, OLD.moduser_id);
        RETURN NEW;
END;
' LANGUAGE 'plpgsql';

CREATE TRIGGER projects_update BEFORE DELETE ON projects
	FOR EACH ROW EXECUTE PROCEDURE projects_update();
