------------------------
--  Technical Reports --
------------------------
CREATE TABLE technicalreports ( -- No. 1
    id SERIAL,
    authors text NOT NULL,
    title   text NOT NULL,
    reference text NOT NULL,
    year int4 NOT NULL,
    uid int4 NOT NULL CONSTRAINT s__ref_uid  -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (authors, title, reference)
);

CREATE TABLE researcherthecnicalreports ( -- No. 2
   id SERIAL,
   trid int4 NOT NULL CONSTRAINT rtp__ref_trid
            REFERENCES technicalreports(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   researcherrole int4 NOT NULL CONSTRAINT rtr__ref_researcherrole
            REFERENCES researcherrole(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   uid int4 NOT NULL CONSTRAINT rs__ref_uid  
            REFERENCES users(id)            
	    ON UPDATE CASCADE               
            ON DELETE CASCADE
            DEFERRABLE,
   year int4 NOT NULL,
   dbuser text DEFAULT CURRENT_USER,
   dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (id),
   UNIQUE (trid, uid)
);
