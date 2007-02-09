----------------------------------------
-- General Information                --
----------------------------------------
CREATE TABLE maritalstatuses ( 
    	id serial NOT NULL,
    	name text NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE maritalstatuses IS
	'Estado civil: 
	 Casado, soltero, divorciado, viudo, unión libre, ...';

CREATE TABLE addresstypes ( 
	id serial NOT NULL,
   	name text NOT NULL,
   	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE addresstypes IS
	'Tipo de dirección:
	 Domicilio profesional, Domicilio particular, Domicilio temporal';

CREATE TABLE people ( 
    user_id int4 NOT NULL 
            REFERENCES users(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    firstname text NOT NULL,
    lastname1 text NOT NULL,
    lastname2 text NULL,
    gender boolean NOT NULL,
    maritalstatus_id int4 NULL 
                           REFERENCES maritalstatuses(id)
                           ON UPDATE CASCADE
                           DEFERRABLE,
    dateofbirth date NOT NULL,
    country_id int4 NOT NULL 
                         REFERENCES countries(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
    state_id int4 NULL
			REFERENCES states(id)
			ON UPDATE CASCADE
			DEFERRABLE,
    city_id int4 NULL
			REFERENCES cities(id)
			ON UPDATE CASCADE
			DEFERRABLE,
    photo_filename text NULL,
    photo_content_type text NULL,
    photo bytea NULL,
    other text NULL,
    moduser_id int4  NULL    	     -- Use it only to know who has
    REFERENCES users(id)             -- inserted, updated or deleted  
    ON UPDATE CASCADE                -- data into or from this table.
              DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id)
);
CREATE INDEX "people_firstname_idx" ON people(firstname);
CREATE INDEX "people_lastname1_idx" ON people(lastname1);
CREATE INDEX "people_lastname2_idx" ON people(lastname2);
COMMENT ON TABLE people IS
	'Datos personales del usuario';
COMMENT ON COLUMN people.country_id IS
	'Pais de nacimiento';
COMMENT ON COLUMN people.state_id IS
	'Estado donde nacio';
COMMENT ON COLUMN people.city_id IS
	'Ciudad o municipio de nacimiento';
COMMENT ON COLUMN people.gender IS
        'Gender será usado de la siguiente manera: f para indicar el genéro femenino y t para indicar el genéro másculino';

CREATE TABLE addresses ( 
    id SERIAL,
    user_id int4 NOT NULL 
            REFERENCES users(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    addresstype_id int4 NOT NULL 
            REFERENCES addresstypes(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    addr text NOT NULL, 
    pobox text NULL,
    country_id int4 NOT NULL 
              REFERENCES countries(id)
              ON UPDATE CASCADE
              DEFERRABLE,
    state_id int4 NULL
		REFERENCES states(id)
		ON UPDATE CASCADE
		DEFERRABLE,
    city_id int4 NULL
		REFERENCES cities(id)
		ON UPDATE CASCADE
		DEFERRABLE,
    zipcode int4 NULL,
    phone text NULL,
    fax text NULL,
    movil text NULL,
    other text NULL,
    is_postaddress bool DEFAULT 'f' NOT NULL,
    moduser_id int4  NULL    	     -- Use it only to know who has
    REFERENCES users(id)             -- inserted, updated or deleted  
	      ON UPDATE CASCADE                -- data into or from this table.
   	      DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (user_id, addresstype_id)
);
COMMENT ON TABLE addresses IS
	'Las direcciones postales de un usuario';

CREATE TABLE migratorystatuses (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY (id), 
	UNIQUE (name)
);
COMMENT ON TABLE migratorystatuses IS
	'Status migratorio de un extranjero:
	Turista, residente temporal, residente permanente';

CREATE TABLE citizenmodalities (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY (id), 
	UNIQUE (name)
);
COMMENT ON TABLE citizenmodalities IS
	'Modalidad de la nacionalidad:
 	Por nacimiento, Por naturalizaciÃn, Otro.';

CREATE TABLE citizens ( 
  id serial,
  user_id int4 NOT NULL 
	   REFERENCES users(id)
	   ON UPDATE CASCADE
           ON DELETE CASCADE
	   DEFERRABLE,
  citizen_country_id int4 NOT NULL
	   REFERENCES countries(id)
	   ON UPDATE CASCADE
           DEFERRABLE,
  migratorystatus_id int4 NOT NULL 
           REFERENCES migratorystatuses(id)
	   ON UPDATE CASCADE
           DEFERRABLE,
  citizenmodality_id int4 NOT NULL 
           REFERENCES citizenmodalities(id)
	   ON UPDATE CASCADE
           DEFERRABLE,
  moduser_id int4  NULL    	     -- Use it only to know who has
  REFERENCES users(id)             -- inserted, updated or deleted  
	      ON UPDATE CASCADE                -- data into or from this table.
   	      DEFERRABLE,
  created_on timestamp DEFAULT CURRENT_TIMESTAMP,
  updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE (user_id, citizen_country_id)
);
COMMENT ON TABLE citizens IS
	'Nacionalidades que tiene un usuario';

CREATE TABLE idtypes (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY(id),
	UNIQUE (name)
);
COMMENT ON TABLE idtypes IS
	'Tipo de (documento de) identificación:
	Pasaporte, credencial de elector, ...';

CREATE TABLE identifications (
	id SERIAL,
	idtype_id int4 NOT NULL 
		 REFERENCES idtypes(id)
           	ON UPDATE CASCADE
           	DEFERRABLE,
	citizen_country_id int4 NOT NULL 
		 REFERENCES countries(id)
           	ON UPDATE CASCADE
           	DEFERRABLE,
	moduser_id int4  NULL    	     -- Use it only to know who has
		REFERENCES users(id)             -- inserted, updated or deleted  
	      	ON UPDATE CASCADE                -- data into or from this table.
   	      	DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE (idtype_id, citizen_country_id)
);

CREATE TABLE people_identifications ( 
   id serial,
   user_id int4 NOT NULL 
   	   REFERENCES users(id)
           ON UPDATE CASCADE
           ON DELETE CASCADE   
           DEFERRABLE,
   identification_id int4 NOT NULL 
           REFERENCES identifications(id)
           ON UPDATE CASCADE
           DEFERRABLE,
   descr text NOT NULL,
   moduser_id int4  NULL    	     -- Use it only to know who has
   REFERENCES users(id)              -- inserted, updated or deleted  
	      ON UPDATE CASCADE      -- data into or from this table.
   	      DEFERRABLE,
   created_on timestamp DEFAULT CURRENT_TIMESTAMP,
   updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (user_id),
   UNIQUE (user_id, identification_id)
);
COMMENT ON TABLE people_identifications IS
	'Identificaciones de un usuario asociadas a su nacionalidad';

CREATE TABLE memberships ( 
  id serial,
  user_id int4 NOT NULL 
	   REFERENCES users(id)
	   ON UPDATE CASCADE
           ON DELETE CASCADE
	   DEFERRABLE,
  institution_id int4 NOT NULL
	   REFERENCES institutions(id)
	   ON UPDATE CASCADE
           DEFERRABLE,
  descr text NULL,
  startyear int4 NULL,
  endyear int4 NULL,
  moduser_id int4  NULL    	     -- Use it only to know who has
 	   REFERENCES users(id)             -- inserted, updated or deleted  
	   ON UPDATE CASCADE                -- data into or from this table.
   	   DEFERRABLE,
  created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);
COMMENT ON TABLE memberships IS
	'Instituciones(Asociaciones) académicas a las que pertenece un usuario';

