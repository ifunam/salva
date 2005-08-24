----------------------
-- Other Activities --
----------------------
CREATE TABLE otheractivities ( 
    id SERIAL,
    activity text NOT NULL,
    moduser_id int4 NOT NULL    -- Use it only to know who has
       	   REFERENCES users(id)    -- inserted, updated or deleted  
           ON UPDATE CASCADE       -- data into or from this table.
           DEFERRABLE,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
);

CREATE TABLE userotheractivities ( 
    id SERIAL,
    uid int4 NOT NULL
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    userrole_id int4 NULL
            REFERENCES userrole(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    otheractivities_id int4 NOT NULL
            REFERENCES otheractivities(id)      
            ON UPDATE CASCADE
            DEFERRABLE,
    year int4 NOT NULL,
    month int4 NULL CHECK (month >= 1 AND month <= 12),
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (uid, otheractivities_id, year, month)
);
