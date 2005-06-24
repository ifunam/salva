
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
