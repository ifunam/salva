--------------------
-- Research Lines -- 
--------------------
CREATE TABLE researchlines ( -- No. 1
    id SERIAL,
    line character(255) NOT NULL,
    uid int4 NOT NULL CONSTRAINT r__ref_uid  -- Use it only to know who has
            REFERENCES users(id)             -- inserted, update or delete  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
CREATE INDEX researchlines_line_idx ON researchlines(line);

CREATE TABLE researcherlines ( -- No. 2
    uid int4 NOT NULL CONSTRAINT rl__ref_uid 
            REFERENCES users(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    rlid int4 NOT NULL CONSTRAINT rl__ref_rlid 
            REFERENCES researchlines(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    date date NULL,
    comments date NULL,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (uid, rlid)
);

 
-----------------------------------------------------------
-- Tables for log all the changes in the previus tables  --
-----------------------------------------------------------

CREATE TABLE researchlines_logs ( -- No. 3
    id int4,
    line character(255) NOT NULL,
    uid int4 NOT NULL,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    dbmodtype char(1)
);


CREATE TABLE researcherlines_logs ( -- No. 4
    uid int4, 
    rlid int4 NOT NULL,
    date date NULL,
    comments date NULL,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    dbmodtype char(1)
);

---------
- Rules -
---------

CREATE RULE researchlines_update AS     -- UPDATE rule
ON UPDATE TO researchlines 
DO 
INSERT INTO researchlines_logs( id, line, uid, dbmodtype )
            VALUES ( old.id, old.line, old.uid, 'U' );

CREATE RULE researchlines_delete AS     -- DELETE rule
ON DELETE TO researchlines 
DO 
INSERT INTO researchlines_logs( id, line, uid, dbmodtype )
            VALUES ( old.id, old.line, old.uid, 'D' );

CREATE RULE researcherlines_update AS     -- UPDATE rule
ON UPDATE TO researcherlines 
DO 
INSERT INTO researcherlines_logs( uid, rlid, date, comments, dbmodtype )
            VALUES ( old.uid, old.rlid, old.date, old.comments, 'U' );

CREATE RULE researcherlines_delete AS     -- DELETE rule
ON DELETE TO researcherlines 
DO 
INSERT INTO researcherlines_logs( uid, rlid, date, comments, dbmodtype )
            VALUES ( old.uid, old.rlid, old.date, old.comments, 'D' );

