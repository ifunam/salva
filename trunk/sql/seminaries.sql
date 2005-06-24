----------------
-- Seminaries --
----------------
CREATE TABLE seminaries ( -- No. 1
    id SERIAL,
    title text NOT NULL,
    place text NOT NULL,
    year  int4 NOT NULL,
    uid int4 NOT NULL CONSTRAINT s__ref_uid  -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (title, place, year)
);

CREATE TABLE researcherseminaries ( -- No. 2
    id SERIAL,
    sid int4 NOT NULL CONSTRAINT rs__ref_sid
            REFERENCES seminaries(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    researcherrole int4 NOT NULL CONSTRAINT rs__ref_researcherrole
            REFERENCES researcherrole(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    uid int4 NOT NULL CONSTRAINT rs_ref_uid 
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (researcherrole, uid, sid)
);

