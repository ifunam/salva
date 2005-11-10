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

---------------
-- Log table --
---------------
CREATE TABLE others_logs ( -- No. 3
    id int4,
    activity text NOT NULL,
    year int4 NOT NULL,
    uid int4 NOT NULL,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    dbmodtype char(1)
);

CREATE TABLE researcherothers_logs ( -- No. 4
    id int4,
    uid int4 NOT NULL,
    othersid int4 NOT NULL,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    dbmodtype char(1)
);


-----------
-- Rules --
-----------

CREATE RULE others_update AS     -- UPDATE rule
ON UPDATE TO others
DO 
INSERT INTO others_logs( id, activity, year, uid, dbmodtype )
	                VALUES( old.id, old.activity, old.year, old.uid, 'U' );


CREATE RULE others_delete AS     -- DELETE rule
ON DELETE TO others
DO 
INSERT INTO others_logs( id, activity, year, uid, dbmodtype )
	                VALUES( old.id, old.activity, old.year, old.uid, 'D' );

CREATE RULE researcherothers_update AS     -- UPDATE rule
ON UPDATE TO researcherothers
DO 
INSERT INTO researcherothers_logs ( id, uid, othersid, dbmodtype )
                           VALUES ( old.id, old.uid, old.othersid, 'D' );

CREATE RULE researcherothers_delete AS     -- DELETE rule
ON DELETE TO researcherothers
DO 
INSERT INTO researcherothers_logs ( id, uid, othersid, dbmodtype )
                           VALUES ( old.id, old.uid, old.othersid, 'D' );
