-----------------------
-- Research Projects --
-----------------------

-- Estas tablas dependen de la existencia de las de conferences.sql.

CREATE TABLE projecttypes (
        id SERIAL,
        name text NOT NULL,
        PRIMARY KEY (id),
        UNIQUE (name)
);
COMMENT ON TABLE projecttypes IS
        'Tipos de proyectos';
-- Investigación, Docencia, Apoyo, Infraestructura, Otro.

CREATE TABLE projectstatuses (
        id SERIAL,
        name text NOT NULL,
        PRIMARY KEY (id),
        UNIQUE (name)
);
COMMENT ON TABLE projectstatuses IS
        'Estado de los proyectos';
-- En desarrollo, planeación, terminado,

CREATE TABLE projects (
    id SERIAL,
    name   text NOT NULL,
    responsible text NOT NULL,
    descr text NOT NULL,
    projecttype_id integer NOT NULL
            REFERENCES projecttypes(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    projectstatus_id integer NOT NULL
            REFERENCES projectstatuses(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    project_id integer NULL
            REFERENCES projects(id)
            ON UPDATE CASCADE
            DEFERRABLE,
--    subject  text NULL,
    abstract  text NULL,
    abbrev   text NULL,
--    goals   text NULL,
--    notes   text NULL,
    startyear int4 NOT NULL,
    startmonth int4 NULL CHECK (startmonth >= 1 AND startmonth <= 12),
    endyear int4  NULL,
    endmonth int4 NULL CHECK (endmonth >= 1 AND endmonth <= 12),
    url      text NULL,
    other    text NULL,
    moduser_id int4 NULL  -- Use it only to know who has
               REFERENCES users(id)             -- inserted, update or delete
               ON UPDATE CASCADE                -- data into or from this table.
               DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    UNIQUE (name)
--    CONSTRAINT valid_duration CHECK (endyear IS NULL OR
--             (startyear * 12 + coalesce(startmonth,0)) > (endyear * 12 + coalesce(endmonth,0)))
);
CREATE INDEX projects_name_idx ON projects(name);
CREATE INDEX projects_descr_idx ON projects(descr);
COMMENT ON TABLE projects IS
        'Datos generales de cada uno de los proyectos';
COMMENT ON COLUMN projects.project_id IS
        'Para implementar sub-proyectos, relacionamos con un proyecto padre';
COMMENT ON COLUMN projects.responsible IS
        'Nombre del responsable del proyecto';
--COMMENT ON COLUMN projects.subject IS
--      'Temática, tema (no confundir con name)';
COMMENT ON COLUMN projects.abbrev IS
        'Acrónimo';
--COMMENT ON COLUMN projects.notes IS
--      'Logros y avances';
COMMENT ON COLUMN projects.other IS
        'Número de alumnos, grado, etc.';

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
        'Relación del proyecto con instituciones';

CREATE TABLE projectresearchlines (
    id SERIAL,
    project_id integer NOT NULL
            REFERENCES projects(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    researchline_id integer NOT NULL
            REFERENCES researchlines(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    other text NULL,
    PRIMARY KEY (id),
    UNIQUE (project_id, researchline_id)
);
COMMENT ON TABLE projectresearchlines IS
        'Relación del proyecto con las líneas de investigación';

CREATE TABLE projectresearchareas (
    id SERIAL,
    project_id integer NOT NULL
            REFERENCES projects(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    researcharea_id integer NOT NULL
            REFERENCES researchareas(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    other text NULL,
    PRIMARY KEY (id),
    UNIQUE (project_id, researcharea_id)
);
COMMENT ON TABLE projectresearchareas IS
        'Relación del proyecto con las áreas de investigación';

CREATE TABLE projectfiles (
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
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (project_id, filename)
);
COMMENT ON TABLE projectfiles IS
        'Archivos relacionados a los proyectos';
COMMENT ON COLUMN projectfiles.content IS
        'Contenido (binario) del archivo';

CREATE TABLE projectfinancingsources (
    id SERIAL,
    project_id integer NOT NULL
            REFERENCES projects(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    institution_id integer NOT NULL
            REFERENCES institutions(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    amount text NOT NULL,  -- Money is deprecated, we should use numeric or float in combination with the to_char function, but it sucks for *rails*
    other text NULL,
    PRIMARY KEY (id),
    UNIQUE (project_id, institution_id )
);
COMMENT ON TABLE projectfinancingsources IS
        'Fuentes de financiamiento (instituciones) de cada proyecto';

CREATE TABLE roleinprojects (
        id SERIAL,
        name text NOT NULL,
        PRIMARY KEY (id),
        UNIQUE(name)
);
COMMENT ON TABLE roleinprojects IS
        'Roles en un proyecto';
-- Responsable, corresponsable, participante, apoyo a la investigación (T.A.),
-- becario; etc.

CREATE TABLE user_projects (
   id SERIAL,
   project_id integer NOT NULL
            REFERENCES projects(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   user_id integer NOT NULL
             REFERENCES users(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   roleinproject_id integer NOT NULL
            REFERENCES roleinprojects(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   moduser_id int4 NULL                     -- Use it to known who
   REFERENCES users(id)            -- has inserted, updated or deleted
   ON UPDATE CASCADE               -- data into or  from this table.
   DEFERRABLE,
   created_on timestamp DEFAULT CURRENT_TIMESTAMP,
   updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (id),
   UNIQUE (project_id, user_id, roleinproject_id)
);
COMMENT ON TABLE user_projects IS
        'Relación entre usuarios y proyectos';
-- COMMENT ON COLUMN user_projects.user_is_internal IS
--      'El usuario es interno del sistema? Si sí, exigimos internaluser_id;
--      si no, exigimos externaluser_id';

CREATE TABLE projectarticles (
        id serial,
        project_id integer NOT NULL
            REFERENCES projects(id)
            ON UPDATE CASCADE
            DEFERRABLE,
        article_id integer NOT NULL
            REFERENCES articles(id)
            ON UPDATE CASCADE
            DEFERRABLE,
        PRIMARY KEY (id),
        UNIQUE (project_id, article_id)
);
COMMENT ON TABLE projectarticles IS
        'Artículos relacionados con un proyecto';

CREATE TABLE projecttheses (
        id serial,
        project_id integer NOT NULL
            REFERENCES projects(id)
            ON UPDATE CASCADE
            DEFERRABLE,
        thesis_id integer NOT NULL
            REFERENCES theses(id)
            ON UPDATE CASCADE
            DEFERRABLE,
        PRIMARY KEY (id),
        UNIQUE (project_id, thesis_id)
);
COMMENT ON TABLE projecttheses IS
        'Tesis relacionados con un proyecto';

CREATE TABLE projectbooks (
        id serial,
        project_id integer NOT NULL
            REFERENCES projects(id)
            ON UPDATE CASCADE
            DEFERRABLE,
        book_id integer NOT NULL
            REFERENCES books(id)
            ON UPDATE CASCADE
            DEFERRABLE,
        PRIMARY KEY (id),
        UNIQUE (project_id, book_id)
);
COMMENT ON TABLE projectbooks IS
        'Libros relacionados con cada proyecto';

CREATE TABLE projectchapterinbooks (
        id serial,
        project_id integer NOT NULL
            REFERENCES projects(id)
            ON UPDATE CASCADE
            DEFERRABLE,
        chapterinbook_id integer NOT NULL
            REFERENCES chapterinbooks(id)
            ON UPDATE CASCADE
            DEFERRABLE,
        PRIMARY KEY (id),
        UNIQUE (project_id, chapterinbook_id)
);
COMMENT ON TABLE projectchapterinbooks IS
        'Capítulos en libro relacionados con cada proyecto';

CREATE TABLE projectconferencetalks (
        id serial,
        project_id integer NOT NULL
            REFERENCES projects(id)
            ON UPDATE CASCADE
            DEFERRABLE,
        conferencetalk_id integer NOT NULL
            REFERENCES conferencetalks(id)
            ON UPDATE CASCADE
            DEFERRABLE,
        PRIMARY KEY (id),
        UNIQUE (project_id, conferencetalk_id)
);
COMMENT ON TABLE projectconferencetalks IS
        'Ponencias en congreso relacionadas con cada proyecto';

CREATE TABLE projectacadvisits (
        id serial,
        project_id integer NOT NULL
            REFERENCES projects(id)
            ON UPDATE CASCADE
            DEFERRABLE,
        acadvisit_id integer NOT NULL
            REFERENCES acadvisits(id)
            ON UPDATE CASCADE
            DEFERRABLE,
        PRIMARY KEY (id),
        UNIQUE (project_id, acadvisit_id)
);
COMMENT ON TABLE projectacadvisits IS
        'Estancias académicas relacionadas con cada proyecto';

CREATE TABLE projectgenericworks (
        id serial,
        project_id integer NOT NULL
            REFERENCES projects(id)
            ON UPDATE CASCADE
            DEFERRABLE,
        genericwork_id integer NOT NULL
            REFERENCES genericworks(id)
            ON UPDATE CASCADE
            DEFERRABLE,
        PRIMARY KEY (id),
        UNIQUE (project_id, genericwork_id)
);
COMMENT ON TABLE projectgenericworks IS
        'Trabajos genéricos relacionados con cada proyecto';

