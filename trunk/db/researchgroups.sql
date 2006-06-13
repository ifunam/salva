CREATE TABLE researchgroups (
	id SERIAL,
	name text NOT NULL,
	descr text NULL,
	moduser_id int4 NULL        -- Use it only to know who has
        	REFERENCES users(id)    -- inserted, updated or deleted  
           	ON UPDATE CASCADE       -- data into or from this table.
           	DEFERRABLE,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE researchgroups IS
	'Grupos de investigación (e.g.): 
	 Grupo de Propiedades Ópticas de Defectos en Sólidos 
	 Grupo de Biocomplejidad y Redes
	 ....';

CREATE TABLE groupmodalities (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);	
COMMENT ON TABLE groupmodalities IS
	'Modalidad de un grupo de investigación: Administrativa, Académica, etc..';

CREATE TABLE researchgroupmodalities (
	id SERIAL,
	groupmodality_id smallint NULL 
                         REFERENCES groupmodalities(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
	researchgroup_id smallint NOT NULL 
                         REFERENCES researchgroups(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
	adscription_id smallint NULL 
                         REFERENCES adscriptions(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
	PRIMARY KEY (id)
);
COMMENT ON TABLE researchgroupmodalities IS
	'Las entidades de la dependencia (o externas) relacionadas al proyeto
	cada una con su modalidad correspondiente';

CREATE TABLE userresearchgroups (
   id SERIAL,
   researchgroup_id integer NOT NULL 
            REFERENCES researchgroups(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   year int4 NOT NULL,
   user_is_internal bool,
   externaluser_id integer 
            REFERENCES externalusers(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
   internaluser_id integer 
             REFERENCES users(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
   moduser_id int4 NULL    -- Use it only to know who has
           REFERENCES users(id)    -- inserted, updated or deleted  
           ON UPDATE CASCADE       -- data into or from this table.
           DEFERRABLE,
   PRIMARY KEY (id),
   UNIQUE (researchgroup_id, internaluser_id ),
   UNIQUE (researchgroup_id, externaluser_id ),
   -- Sanity checks: If this is a full system user, require the user
   -- to be filled in. Likewise for an external one.
   CHECK (user_is_internal = 't' OR
	(internaluser_id IS NOT NULL AND externaluser_id IS NULL)),
   CHECK (user_is_internal = 'f' OR
	(externaluser_id IS NOT NULL AND internaluser_id IS NULL))
);
COMMENT ON TABLE userresearchgroups IS
	'Grupos de investigación a los que pertenece un usuario (interno o
	externo)';
COMMENT ON COLUMN userresearchgroups.year IS
	'Año en que comenzó a participar en el grupo'
