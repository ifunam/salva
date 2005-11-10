--------------------
-- Cites -- `
--------------------
CREATE TABLE cites ( -- No. 1
    id SERIAL,
    uid int4 NOT NULL CONSTRAINT c__ref_uid 
            REFERENCES users(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    num int4 NOT NULL,
    year int4 NOT NULL,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (uid, year)
);

---------------
-- Log table --
---------------

CREATE TABLE cites_logs ( -- No. 2
    id int4,
    uid int4 NOT NULL,
    num int4 NOT NULL,
    year int4 NOT NULL,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    dbmodtype char(1)
);

-----------
-- Rules --
-----------

CREATE RULE cites_update AS     -- UPDATE rule
ON UPDATE TO cites 
DO 
INSERT INTO cites_logs( id, uid, num, year, dbmodtype )
                VALUES( old.id, old.uid, old.num, old.year, 
			'U' );

CREATE RULE cites_delete AS     -- DELETE rule
ON delete TO cites 
DO 
INSERT INTO cites_logs( id, uid, num, year, dbmodtype )
                VALUES( old.id, old.uid, old.num, old.year, 
			'D' );
