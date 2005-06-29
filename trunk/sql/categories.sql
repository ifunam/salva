-----------------------------------------
-- Researcher - Categories Information --
-----------------------------------------
CREATE TABLE researchercategories ( -- No. 1
    id SERIAL,
    uid int4 NOT NULL
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    cid int4 NOT NULL
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
    uid int4 NOT NULL
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    did int4 NOT NULL
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
