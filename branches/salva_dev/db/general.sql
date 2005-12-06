----------------------------------------
-- General Information                --
----------------------------------------

CREATE TABLE maritalstatus ( 
    	id serial NOT NULL,
    	name text NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE maritalstatus IS
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

CREATE TABLE personalidtypes ( 
        id SERIAL,
        name text NOT NULL,
        PRIMARY KEY(id),
	UNIQUE (name)
);
COMMENT ON TABLE personalidtypes IS
	'Tipo de (documento de) identificación';
-- Pasaporte, credencial de elector, ...

CREATE TABLE migratorystatuses (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY (id), 
	UNIQUE (name)
);
COMMENT ON TABLE migratorystatuses IS
	'Status migratorio de un extranjero';
-- Turista, residente temporal, residente permanente

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
    dateofbirth date NOT NULL,
    birth_country_id int4 NOT NULL 
                         REFERENCES countries(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
    birthcity text NOT NULL,
    birth_state_id int4 NULL
			REFERENCES states(id)
			ON UPDATE CASCADE
			DEFERRABLE,
    maritalstatu_id int4 NOT NULL 
                           REFERENCES maritalstatus(id)
                           ON UPDATE CASCADE
                           DEFERRABLE,
    photo bytea NULL,
    other text NULL,
    dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id)
);
CREATE INDEX "personals_firstname_idx" ON personals(firstname);
CREATE INDEX "personals_lastname1_idx" ON personals(lastname1);
CREATE INDEX "personals_lastname2_idx" ON personals(lastname2);
CREATE UNIQUE INDEX "personals_firstname_lastname1_lastname2_idx" ON personals(upper(firstname), upper(lastname1), upper(lastname2), dateofbirth);
COMMENT ON TABLE personals IS
	'Datos personales del usuario';

CREATE TABLE personalids ( 
   user_id int4 NOT NULL 
   	   REFERENCES users(id)
           ON UPDATE CASCADE
           ON DELETE CASCADE   
           DEFERRABLE,
   personalidtype_id int4 
   	   REFERENCES personalidtypes(id)
           ON UPDATE CASCADE
           DEFERRABLE,
   content text NULL,
   dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (user_id)
);
COMMENT ON TABLE personalids IS
	'Cada una de las identificaciones de un usuario';

CREATE TABLE addresses ( 
    user_id int4 NOT NULL 
            REFERENCES users(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    addresstype_id int4 NOT NULL 
            REFERENCES addresstypes(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    country_id int4 NOT NULL 
              REFERENCES countries(id)
              ON UPDATE CASCADE
              DEFERRABLE,
    postaddress text NOT NULL, 
    state_id int4 NULL
		REFERENCES states(id)
		ON UPDATE CASCADE
		DEFERRABLE,
    city text NOT NULL,
    zipcode int4 NULL,
    phone text NULL,
    fax text NULL,
    movil text NULL,
    other text NULL,
    mail bool DEFAULT 'f' NOT NULL,
    dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, addresstype_id)
);
COMMENT ON TABLE addresses IS
	'Las direcciones postales de un usuario';

CREATE TABLE user_citizens ( 
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
  passport text NULL,
  dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, citizen_country_id)
);
COMMENT ON TABLE user_citizens IS
	'Nacionalidades que tiene un usuario';

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
  dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, institution_id)
);
COMMENT ON TABLE user_memberships IS
	'Instituciones académicas a las que pertenece un usuario';

