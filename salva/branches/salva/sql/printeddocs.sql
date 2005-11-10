
CREATE TABLE printeddocs( -- No. 1
    id SERIAL,
    uid int4 NOT NULL CONSTRAINT pd__ref_uid 
            REFERENCES users(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    did int4 NOT NULL CONSTRAINT pd__ref_did 
            REFERENCES doctype(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    ipaddress inet NOT NULL,
    timestamp timestamp NOT NULL,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (uid, ipaddress, did, timestamp)
);


----------------
-- Log tables --
----------------

CREATE TABLE printeddocs_logs ( -- No. 2
    id SERIAL,
    uid int4 NOT NULL,
    did int4 NOT NULL,
    ipaddress inet NOT NULL,
    timestamp timestamp NOT NULL,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    dbmodtype char(1)
);

-----------
-- Rules --
-----------

CREATE RULE printeddocs_update AS	-- UPDATE rule
ON UPDATE TO printeddocs
DO
INSERT INTO printeddocs_logs ( id, uid, did, ipaddress, timestamp, dbmodtype )
		       VALUES( old.id, old.uid, old.did, old.ipaddress, 
			       old.timestamp, 'U' );

CREATE RULE printeddocs_delete AS	-- DELETE rule
ON DELETE TO printeddocs
DO
INSERT INTO printeddocs_logs ( id, uid, did, ipaddress, timestamp, dbmodtype )
		       VALUES( old.id, old.uid, old.did, old.ipaddress, 
			       old.timestamp, 'D' );

