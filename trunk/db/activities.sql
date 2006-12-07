----------------------
-- Other Activities --
----------------------
CREATE TABLE activitygroups (
	id serial,
	name text NOT NULL,
	PRIMARY KEY (id),
	moduser_id int4 NULL               	    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	UNIQUE (name)
);
COMMENT ON TABLE activitygroups IS
	'Listado del grupo al que pertenecen las otras actividades:
	Actividades de divulgación
	Actividades de extensión
	Actividades de difusión
	Servicios de apoyo
	Asesorías y consultorías
	Actividades de docencia
	Actividades de vinculación
	Actividades artisticas
	Otras actividades';

CREATE TABLE activitytypes (
	id serial,
	name text NOT NULL,
	abbrev text NULL,
	activitygroup_id int4 NOT NULL   
	    REFERENCES activitygroups(id) 
            ON UPDATE CASCADE 
            DEFERRABLE,
	moduser_id int4 NULL    	     -- Use it only to know who has
	    REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE (name),
	UNIQUE (abbrev)
);
COMMENT ON TABLE activitytypes IS
	'Listado de otro tipo de actividades:
	* Actividades de divulgación:
	Organización de actividades de divulgación
	...

	Actividades de difusión:
	Programas de radio
	Entrevistas
	Reportajes
	Crónicas
	Opiniones
	Elaboración de guiones
	Conducción de programas de radio
	Conducción de programas de TV
	Crestomatias
	Participación en programas de radio y TV
	Otras actividades de difusión
	...

	Actividades de extensión:
	Exhibiciones
	Presentaciones
	Excursiones (museos, centros o institutos de investigación, facultades)
	Visitas guiadas
	...

	Servicios de apoyo:
	Actividades de servicio en su área
	Asesorías profesionales
	Servicios internos
	Servicios a otras dependencias de la UNAM
	Servicios a instituciones externas
	...

	Asesorías y consultorías
	A estudiantes
	A profesores
	A proyectos de investigación
	...

	Actividades de docencia:
	Servicios de apoyo 
	Programas de estudios
	Evaluación de aprendizaje
	Otras actividades docentes no incluídas

	Actividades de vinculación
	Convenios
	...

	Actividades artisticas
	?
	...';

CREATE TABLE activities ( 
    id SERIAL,
    user_id int4 NOT NULL            -- Use it only to know who has
            REFERENCES users(id) -- inserted, updated or deleted  
            ON UPDATE CASCADE    -- data into or from this table.
            DEFERRABLE,
    activitytype_id int4 NOT NULL     
            REFERENCES activitytypes(id)
            ON UPDATE CASCADE 
            DEFERRABLE,
    name   text NOT NULL,
    moduser_id int4 NULL               	    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
COMMENT ON TABLE activities IS
	'Otras actividades académicas en las que participan los usuarios';

CREATE TABLE activityinstitutions (
   activity_id int4 NOT NULL 
            REFERENCES activities(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   institution_id integer NOT NULL 
	    REFERENCES institutions(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
   PRIMARY KEY (activity_id, institution_id)
);
COMMENT ON TABLE activityinstitutions IS
	'Instituciones que participen en otras actividades académicas';

CREATE TABLE user_activities (
   id SERIAL,
   user_id int4 NOT NULL 
            REFERENCES users(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
   userrole_id int4 NULL 
            REFERENCES userroles(id)
            ON UPDATE CASCADE
            DEFERRABLE,  
   activity_id int4 NOT NULL 
            REFERENCES activities(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    startyear int4 NOT NULL,
    startmonth int4 NULL CHECK (startmonth >= 1 AND startmonth <= 12),
    endyear int4  NULL,
    endmonth int4 NULL CHECK (endmonth >= 1 AND endmonth <= 12),
    other text  NULL,
    moduser_id int4 NULL               	    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
COMMENT ON TABLE user_activities IS
	'Relación entre usuarios y las actividades académicas, las fechas de inicio y de termino 
	 corresponden al período de la participación del usuario en la actividad';
