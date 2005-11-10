------------------------
--  Academic History  --
------------------------
CREATE TABLE academicdegree ( -- No. 1
    id SERIAL,
    uid int4 NOT NULL CONSTRAINT ad_ref_uid 
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    did int4 NOT NULL CONSTRAINT ad_ref_did 
            REFERENCES degrees(id)       
            ON UPDATE CASCADE
            DEFERRABLE,
    subtitle char(10) NULL,       -- Iniciales como Sr., M. en C., Dr., etc
    degree  char(255) NOT NULL,-- Nombre del posgrado o carrera
    university char(255) NOT NULL, -- Universidad
    faculty char(255) NOT NULL,     -- Escuela o facultad donde estudio
    datebegin int4 NULL,     -- Año de ingreso
    dateend   int4 NULL,     -- Año de egreso 
    titleholder bool DEFAULT 'f' NOT NULL,      -- Titulado
    datetitle int4 NULL,     -- Año de obtención del grado
    gotdegreetype int2 NOT NULL CONSTRAINT ad_ref_gotdegreetype -- Tipo de obtención 
             REFERENCES gotdegreetype(id)      		        -- del grado:  tesis, 
             ON UPDATE CASCADE                       		-- promedio, ceneval, etc
             DEFERRABLE,
    thesis text NULL,    
    estid char(20) NULL,          -- Matrícula
    professionalid char(30) NULL,         -- Cedula profesional
    average float NULL,
    percentaje int4 NULL,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (uid, degree, university, faculty)
);

----------------
-- Log tables --
----------------

CREATE TABLE academicdegree_logs ( -- No. 2
    id int4,
    uid int4 NOT NULL,
    did int4 NOT NULL,
    subtitle char(10) NULL,
    degree  char(255) NOT NULL,
    university char(255) NOT NULL,
    faculty char(255) NOT NULL,
    datebegin int4 NULL, 
    dateend   int4 NULL, 
    titleholder bool DEFAULT 'f' NOT NULL,
    datetitle int4 NULL, 
    gotdegreetype int2 NOT NULL,
    thesis text NULL,    
    estid char(20) NULL,        
    professionalid char(30) NULL,
    average float NULL,
    percentaje int4 NULL,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP, 
    dbmodtype char(1)
);

-----------
-- Rules --
-----------

CREATE RULE academicdegree_update AS     -- UPDATE rule
ON UPDATE TO academicdegree
DO 
INSERT INTO academicdegree_logs( id, uid, did, subtitle, degree, university,
			         faculty, datebegin, dateend, titleholder, 
				 datetitle, gotdegreetype, thesis, estid, 
		                 professionalid, average, percentaje, 
				 dbmodtype ) 
	    VALUES ( old.id, old.uid, old.did, old.subtitle, old.degree, 
		     old.university, old.faculty, old.datebegin, old.dateend, 
		     old.titleholder, old.datetitle, old.gotdegreetype, 
		     old.thesis, old.estid, old.professionalid, old.average, 
		     old.percentaje, 'U' );

CREATE RULE academicdegree_delete AS     -- DELETE rule
ON UPDATE TO academicdegree
DO 
INSERT INTO academicdegree_logs( id, uid, did, subtitle, degree, university,
			         faculty, datebegin, dateend, titleholder, 
				 datetitle, gotdegreetype, thesis, estid, 
		                 professionalid, average, percentaje, 
				 dbmodtype ) 
	    VALUES ( old.id, old.uid, old.did, old.subtitle, old.degree, 
		     old.university, old.faculty, old.datebegin, old.dateend, 
		     old.titleholder, old.datetitle, old.gotdegreetype, 
		     old.thesis, old.estid, old.professionalid, old.average, 
		     old.percentaje, 'D' );
