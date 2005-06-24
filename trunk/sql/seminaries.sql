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


----------------
-- Log tables --
----------------

CREATE TABLE seminaries_logs ( -- No. 3
    id int4,
    title text NOT NULL,
    place text NOT NULL,
    year  int4 NOT NULL,
    uid int4 NOT NULL,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    dbmodtype char(1)
);

CREATE TABLE researcherseminaries_logs ( -- No. 4
    id int4,
    sid int4 NOT NULL,
    researcherrole int4 NOT NULL,
    uid int4 NOT NULL,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    dbmodtype char(1)
);

-----------
-- Rules --
-----------

CREATE RULE seminaries_update AS     -- UPDATE rule
ON UPDATE TO  seminaries
DO 
INSERT INTO seminaries_logs( id, title, place, year, uid, dbmodtype )
		    VALUES ( old.id, old.title, old.place, old.year, 
			     old.uid, 'U' );

CREATE RULE seminaries_delete AS     -- DELETE rule
ON DELETE TO  seminaries
DO 
INSERT INTO seminaries_logs( id, title, place, year, uid, dbmodtype )
		    VALUES ( old.id, old.title, old.place, old.year, 
			     old.uid, 'D' );

CREATE RULE researcherseminaries_update AS     -- UPDATE rule
ON UPDATE TO  researcherseminaries
DO 
INSERT INTO researcherseminaries_logs( id, sid, researcherrole, uid, 
				       dbmodtype )
	                 VALUES( old.id, old.sid, old.researcherrole, 
			         old.uid, 'U' );

CREATE RULE researcherseminaries_delete AS     -- DELETE rule
ON DELETE TO  researcherseminaries
DO 
INSERT INTO researcherseminaries_logs( id, sid, researcherrole, uid, 
				       dbmodtype )
	                 VALUES( old.id, old.sid, old.researcherrole, 
			         old.uid, 'D' );
