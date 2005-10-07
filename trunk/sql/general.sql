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

CREATE TABLE addresstype ( 
	id serial NOT NULL,
   	name text NOT NULL,
   	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE addresstype IS
	'Tipo de dirección';
-- Personal, de trabajo, temporal

CREATE TABLE personalidtype ( 
        id SERIAL,
        name text NOT NULL,
        PRIMARY KEY(id),
	UNIQUE (name)
);
COMMENT ON TABLE personalidtype IS
	'Tipo de (documento de) identificación';
-- Pasaporte, credencial de elector, ...

CREATE TABLE migratorystatus (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY (id), 
	UNIQUE (name)
);
COMMENT ON TABLE migratorystatus IS
	'Status migratorio de un extranjero';
-- Turista, residente temporal, residente permanente

CREATE TABLE personal ( 
    uid int4 NOT NULL 
            REFERENCES users(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    firstname text NOT NULL,
    lastname1 text NOT NULL,
    lastname2 text NULL,
    sex boolean NOT NULL,
    dateofbirth date NOT NULL,
    birthcountry_id int4 NOT NULL 
                         REFERENCES countries(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
    birthcity text NOT NULL,
    birthstate int4 NULL
			REFERENCES states(id)
			ON UPDATE CASCADE
			DEFERRABLE,
    maritstat_id int4 NOT NULL 
                           REFERENCES maritalstatus(id)
                           ON UPDATE CASCADE
                           DEFERRABLE,
    photo bytea NULL,
    other text NULL,
    dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (uid)
);
CREATE INDEX "personal_firstname_idx" ON personal(firstname);
CREATE INDEX "personal_lastname1_idx" ON personal(lastname1);
CREATE INDEX "personal_lastname2_idx" ON personal(lastname2);
CREATE UNIQUE INDEX "personal_firstname_lastname1_lastname2_idx" ON personal(upper(firstname), upper(lastname1), upper(lastname2), dateofbirth);
COMMENT ON TABLE personal IS
	'Datos personales del usuario';

CREATE TABLE personalid ( 
   uid int4 NOT NULL 
   	   REFERENCES users(id)
           ON UPDATE CASCADE
           ON DELETE CASCADE   
           DEFERRABLE,
   personalidtype_id int4 
   	   REFERENCES personalidtype(id)
           ON UPDATE CASCADE
           DEFERRABLE,
   content text NULL,
   dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (uid)
);
COMMENT ON TABLE personalid IS
	'Cada una de las identificaciones de un usuario';

CREATE TABLE address ( 
    uid int4 NOT NULL 
            REFERENCES users(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    addrtype_id int4 NOT NULL 
            REFERENCES addresstype(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    country_id int4 NOT NULL 
              REFERENCES countries(id)
              ON UPDATE CASCADE
              DEFERRABLE,
    postaddress text NOT NULL, 
    state int4 NULL
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
    PRIMARY KEY (uid, addrtype_id)
);
COMMENT ON TABLE address IS
	'Las direcciones postales de un usuario';

CREATE TABLE usercitizen ( 
  uid int4 NOT NULL 
	   REFERENCES users(id)
	   ON UPDATE CASCADE
           ON DELETE CASCADE
	   DEFERRABLE,
  citizen_id int4 NOT NULL
	   REFERENCES countries(id)
	   ON UPDATE CASCADE
           DEFERRABLE,
  migratorystatus_id int4 NULL REFERENCES migratorystatus(id)
	   ON UPDATE CASCADE
	   DEFERRABLE,
  passport text NULL,
  dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (uid, citizen_id)
);
COMMENT ON TABLE usercitizen IS
	'Nacionalidades que tiene un usuario';

CREATE TABLE usermembership ( 
  uid int4 NOT NULL 
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
  PRIMARY KEY (uid, institution_id)
);
COMMENT ON TABLE usermembership IS
	'Instituciones académicas a las que pertenece un usuario';

