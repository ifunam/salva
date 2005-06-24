----------------------
-- Other Activities --
----------------------
CREATE TABLE others ( -- No. 1
    id SERIAL,
    activity text NOT NULL,
    year int4 NOT NULL,
    uid int4 NOT NULL CONSTRAINT s__ref_uid  -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (activity, year)
);

CREATE TABLE researcherothers ( -- No. 2
    id SERIAL,
    uid int4 NOT NULL CONSTRAINT ro__ref_uid 
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    othersid int4 NOT NULL CONSTRAINT ro__ref_othersid 
            REFERENCES others(id)      
            ON UPDATE CASCADE
            DEFERRABLE,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (uid, oid)
);
