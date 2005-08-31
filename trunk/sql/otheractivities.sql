----------------------
-- Other Activities --
----------------------
-- Apoyo de actividades académicas     --
-- Servicios de apoyo 		       --
-- Actividades especificas	       --
-- Actividades de servicio en su  área --
-- Asesorías profesionales             --
-- Asesorías a estudiantes	       --
-- Asesoría a proyectos de investigación --
-- Planes y programas de estudios      --
-- Evaluación de aprendizaje --
-- Visitas guiadas --
-- Actividades artisticas --
-- Organización de actividades de divulgación --
-- Actividades académicas no incluídas
-- Otras --
CREATE TABLE otheractivitytypes (
	id serial,
	name text NOT NULL,
	abbrev text NULL,
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

CREATE TABLE otheractivities( 
    id SERIAL,
    uid int4 NOT NULL            -- Use it only to know who has
            REFERENCES users(id) -- inserted, updated or deleted  
            ON UPDATE CASCADE    -- data into or from this table.
            DEFERRABLE,
    otheractivitytypes_id int4 NOT NULL     
            REFERENCES otheractivitytypes(id)
            ON UPDATE CASCADE 
            DEFERRABLE,
    title   text NOT NULL,
    other text  NULL,
    institution_id integer NULL 
	    REFERENCES institutions(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT now(),
    PRIMARY KEY (id)
);
 
CREATE TABLE usersotheractivities (
   id SERIAL,
   otheractivities_id int4 NOT NULL 
            REFERENCES otheractivities(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   uid int4 NOT NULL 
            REFERENCES users(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
   userrole_id int4 NOT NULL 
            REFERENCES userrole(id)
            ON UPDATE CASCADE
            DEFERRABLE,   
   startyear int4 NOT NULL,
   startmonth int4 NULL CHECK (startmonth >= 1 AND startmonth <= 12),
   endyear int4  NULL,
   endmonth int4 NULL CHECK (endmonth >= 1 AND endmonth <= 12),
   dbuser text DEFAULT CURRENT_USER,
   dbtimestamp timestamp DEFAULT now(),
   PRIMARY KEY (id),
   CONSTRAINT valid_duration CHECK (endyear IS NULL OR
	       (startyear * 12 + coalesce(startmonth,0)) > (endyear * 12 + coalesce(endmonth,0)))

);


