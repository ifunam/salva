-------------------------
--  Works of spreading -- 
-------------------------
CREATE TABLE spreading ( -- No. 1
    id SERIAL,
    authors text NOT NULL,
    title   text NOT NULL,
    reference text NOT NULL,
    volume char(30) NULL,
    pages  char(30) NULL,
    year   int4 NOT NULL,
    uid int4 NOT NULL CONSTRAINT s__ref_uid  -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (authors, title, reference, volume, pages)
);

CREATE TABLE researcherspreading ( -- No. 2
   id SERIAL,
   sid int4 NOT NULL CONSTRAINT rs__ref_sid
            REFERENCES spreading(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   year int4 NOT NULL,
   uid int4 NOT NULL CONSTRAINT rs__ref_uid  
            REFERENCES users(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
   dbuser text DEFAULT CURRENT_USER,
   dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (id),
   UNIQUE (sid, uid)
);


----------------
-- Log tables --
----------------

CREATE TABLE spreading_logs ( -- No. 3
    id int4,
    authors text NOT NULL,
    title   text NOT NULL,
    reference text NOT NULL,
    volume char(30) NULL,
    pages  char(30) NULL,
    year   int4 NOT NULL,
    uid int4 NOT NULL,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    dbmodtype char(1)
);

CREATE TABLE researcherspreading_logs ( -- No. 4
   id int4,
   sid int4 NOT NULL,
   year int4 NOT NULL,
   uid int4 NOT NULL,
   dbuser text DEFAULT CURRENT_USER,
   dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
   dbmodtype char(1)
);


-----------
-- Rules --
-----------

CREATE RULE spreading_update AS     -- UPDATE rule
ON UPDATE TO  spreading
DO 
INSERT INTO spreading_logs( id, authors, title, reference, volume, pages, 
			    year, uid, dbmodtype )
		VALUES ( old.id, old.authors, old.title, old.reference, 
			 old.volume, old.pages, old.year, old.uid, 'U' );

CREATE RULE spreading_delete AS     -- DELETE rule
ON DELETE TO  spreading
DO 
INSERT INTO spreading_logs( id, authors, title, reference, volume, pages, 
			    year, uid, dbmodtype )
		VALUES ( old.id, old.authors, old.title, old.reference, 
			 old.volume, old.pages, old.year, old.uid, 'D' );

CREATE RULE researcherspreading_update AS     -- UPDATE rule
ON UPDATE TO  researcherspreading
DO 
INSERT INTO researcherspreading_logs( id, sid, year, uid, dbmodtype )
                            VALUES ( old.id, old.sid, old.year, old.uid, 'U' );

CREATE RULE researcherspreading_delete AS     -- DELETE rule
ON DELETE TO  researcherspreading
DO 
INSERT INTO researcherspreading_logs( id, sid, year, uid, dbmodtype )
                            VALUES ( old.id, old.sid, old.year, old.uid, 'D' );
