-- THIS COULD BE USED BUT IT IS NOT.
CREATE TABLE printeddocs(
    id SERIAL,
    uid int4 NOT NULL 
            REFERENCES users(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    did int4 NOT NULL 
            REFERENCES doctype(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    ipaddress inet NOT NULL,
    timestamp timestamp NOT NULL,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT now(),
    PRIMARY KEY (id),
    UNIQUE (uid, ipaddress, did, timestamp)
);
