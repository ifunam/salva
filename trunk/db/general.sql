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
	'Estado civil';
-- Casado, soltero, divorciado, viudo, unión libre, ...

CREATE TABLE addresstypes ( 
	id serial NOT NULL,
   	name text NOT NULL,
   	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE addresstypes IS
	'Tipo de dirección';
-- Domicilio profesional, Domicilio particular, Domicilio temporal

CREATE TABLE personals ( 
    user_id int4 NOT NULL 
            REFERENCES users(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    firstname text NOT NULL,
    lastname1 text NOT NULL,
    lastname2 text NULL,
    sex boolean NOT NULL,
    maritalstatus_id int4 NOT NULL 
                           REFERENCES maritalstatuses(id)
                           ON UPDATE CASCADE
                           DEFERRABLE,
    dateofbirth date NOT NULL,
    birth_country_id int4 NOT NULL 
                         REFERENCES countries(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
    birth_state_id int4 NULL
			REFERENCES states(id)
			ON UPDATE CASCADE
			DEFERRABLE,
    birth_city_id int4 NULL
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
    dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id)
);
CREATE INDEX "personals_firstname_idx" ON personals(firstname);
CREATE INDEX "personals_lastname1_idx" ON personals(lastname1);
CREATE INDEX "personals_lastname2_idx" ON personals(lastname2);
CREATE UNIQUE INDEX "personals_firstname_lastname1_lastname2_idx" ON personals(upper(firstname), upper(lastname1), upper(lastname2), dateofbirth);
COMMENT ON TABLE personals IS
	'Datos personales del usuario';

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
    dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
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
	'Status migratorio de un extranjero';
-- Turista, residente temporal, residente permanente

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
  migratorystatus_id int4 NULL REFERENCES migratorystatuses(id)
	   ON UPDATE CASCADE
	   DEFERRABLE,
  moduser_id int4  NULL    	     -- Use it only to know who has
  REFERENCES users(id)             -- inserted, updated or deleted  
	      ON UPDATE CASCADE                -- data into or from this table.
   	      DEFERRABLE,
  dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE (user_id, citizen_country_id)
);
COMMENT ON TABLE citizens IS
	'Nacionalidades que tiene un usuario';

CREATE TABLE peopleids (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY(id),
	UNIQUE (name)
);
COMMENT ON TABLE peopleids IS
	'Tipo de (documento de) identificación';
-- Pasaporte, credencial de elector, ...

CREATE TABLE peopleidcitizens ( 
        id SERIAL,
        name text NOT NULL,
	peopleid_id int4 NOT NULL 
        REFERENCES peopleids(id)
                   ON UPDATE CASCADE
                   DEFERRABLE,
	citizen_country_id int4 NOT NULL 
        REFERENCES countries(id)
                   ON UPDATE CASCADE
                   DEFERRABLE,
        PRIMARY KEY(id),
	UNIQUE (peopleid_id, citizen_country_id)
);
COMMENT ON TABLE peopleidcitizens IS
	'Se relaciona la identificación con la nacionalidad';

CREATE TABLE user_peopleidcitizens ( 
   id serial,
   user_id int4 NOT NULL 
   	   REFERENCES users(id)
           ON UPDATE CASCADE
           ON DELETE CASCADE   
           DEFERRABLE,
   peopleidcitizen_id int4 NOT NULL
   	   REFERENCES peopleidcitizens(id)
           ON UPDATE CASCADE
           DEFERRABLE,
   descr text NULL,
   moduser_id int4  NULL    	     -- Use it only to know who has
   REFERENCES users(id)             -- inserted, updated or deleted  
	      ON UPDATE CASCADE                -- data into or from this table.
   	      DEFERRABLE,
   dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (user_id)
);

COMMENT ON TABLE user_peopleidcitizens IS
	'Cada una de las identificaciones de un usuario';

CREATE TABLE user_memberships ( 
  user_id int4 NOT NULL 
	   REFERENCES users(id)
	   ON UPDATE CASCADE
           ON DELETE CASCADE
	   DEFERRABLE,
  institution_id int4 NOT NULL
	   REFERENCES institutions(id)
	   ON UPDATE CASCADE
           DEFERRABLE,
  startyear int4 NULL,
  endyear int4 NULL,
  moduser_id int4  NULL    	     -- Use it only to know who has
  REFERENCES users(id)             -- inserted, updated or deleted  
	      ON UPDATE CASCADE                -- data into or from this table.
   	      DEFERRABLE,
  dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, institution_id)
);
COMMENT ON TABLE user_memberships IS
	'Instituciones académicas a las que pertenece un usuario';

