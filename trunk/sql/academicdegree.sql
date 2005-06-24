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
