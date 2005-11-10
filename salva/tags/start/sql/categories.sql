-----------------------------------------
-- Researcher - Categories Information --
-----------------------------------------
CREATE TABLE researchercategories ( -- No. 1
    id SERIAL,
    uid int4 NOT NULL CONSTRAINT rc__ref_uid 
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    cid int4 NOT NULL CONSTRAINT rc__ref_cid 
            REFERENCES categories(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    yearbegin int4 NULL, -- Year when the researcher got this category
    yearend int4 NULL, -- Year when the researcher got this category
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (uid, cid)
);

CREATE TABLE researcherdepths ( -- No. 2
    id SERIAL,
    uid int4 NOT NULL CONSTRAINT rc__ref_uid 
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    did int4 NOT NULL CONSTRAINT rc__ref_did 
            REFERENCES depths(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    yearbegin int4 NULL, -- Year when the researcher got this category
    yearend int4 NULL, -- Year when the researcher got this category
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (uid, did)
);

----------------
-- Log tables --
----------------

CREATE TABLE researchercategories_logs ( -- No. 3
    id int4,
    uid int4 NOT NULL,
    cid int4 NOT NULL,
    did int4 NOT NULL,
    yearbegin int4 NULL, 
    yearend int4 NULL,
    dbmodtype char(1),
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE researcherdepths_logs ( -- No. 4
    id int4,
    uid int4 NOT NULL,
    did int4 NOT NULL,
    yearbegin int4 NULL,
    yearend int4 NULL,
    dbmodtype char(1),
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP
);

-----------
-- Rules --
-----------

CREATE RULE researchercategories_update AS     -- UPDATE rule
ON UPDATE TO researchercategories 
DO 
INSERT INTO researchercategories_logs( id, uid, cid, yearbegin,
			               yearend, dbmodtype )
            VALUES ( old.id, old.uid, old.cid, old.yearbegin,
		     old.yearend, 'U' );

CREATE RULE researchercategories_delete AS     -- DELETE rule
ON UPDATE TO researchercategories
DO
INSERT INTO researchercategories_logs( id, uid, cid, yearbegin,
			               yearend, dbmodtype )
            VALUES ( old.id, old.uid, old.cid, old.yearbegin,
		     old.yearend, 'D' );

CREATE RULE researcherdepths_update AS     -- UPDATE rule
ON UPDATE TO researcherdepths
DO
INSERT INTO researcherdepths_logs( id, uid, did, yearbegin, yearend, 
				   dbmodtype )
			VALUES ( old.id, old.uid, old.did, old.yearbegin, 
				 old.yearend, 'U' );

CREATE RULE researcherdepths_delete AS     -- DELETE rule
ON DELETE TO researcherdepths
DO
INSERT INTO researcherdepths_logs( id, uid, did, yearbegin, yearend, 
				   dbmodtype )
			VALUES ( old.id, old.uid, old.did, old.yearbegin, 
				 old.yearend, 'D' );

