ARGH GUACALA NO NO NO NO ESTA LISTO MUERETE SI LO EEJECUTAS

-------------------------
--  Works of spreading -- 
-------------------------
CREATE TABLE spreading ( 
    id SERIAL,
    authors text NOT NULL,
    title   text NOT NULL,
    reference text NOT NULL,
    volume char(30) NULL,
    pages  char(30) NULL,
    year   int4 NOT NULL,
    uid int4 NOT NULL            -- Use it only to know who has
            REFERENCES users(id) -- inserted, updated or deleted  
            ON UPDATE CASCADE    -- data into or from this table.
            DEFERRABLE,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (authors, title, reference, volume, pages)
);

CREATE TABLE researcherspreading (
   id SERIAL,
   sid int4 NOT NULL 
            REFERENCES spreading(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   year int4 NOT NULL,
   uid int4 NOT NULL 
            REFERENCES users(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
   dbuser text DEFAULT CURRENT_USER,
   dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (id),
   UNIQUE (sid, uid)
);

