----------------------------------------
-- Estancias                          --
----------------------------------------

CREATE TABLE foreignacadvisits (
	id  SERIAL NOT NULL,
	 uid int4 NOT NULL
            REFERENCES users(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    	institution_id integer NOT NULL 
	    REFERENCES institutions(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
	country_id smallint NOT NULL
            REFERENCES countries(id)
            ON UPDATE CASCADE
            DEFERRABLE,
        name text NOT NULL,
	startyear int4 NOT NULL,
	startmonth int4 NULL CHECK (startmonth >= 1 AND startmonth <= 12),
	endyear int4  NULL,
	endmonth int4 NULL CHECK (endmonth >= 1 AND endmonth <= 12),
	place text NULL,
	goals text NULL,
    	other text  NULL,
	dbuser text DEFAULT CURRENT_USER,
	dbtimestamp timestamp DEFAULT now(),
	PRIMARY KEY(id)
);

CREATE TABLE sponsorsforeignacadvisits (
	id  SERIAL NOT NULL,
	foreignacadvisit_id integer NOT NULL 
	    REFERENCES  foreignacadvisits(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
 	sponsorinst_id integer NOT NULL 
	    REFERENCES institutions(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
	amount integer NOT NULL,
	PRIMARY KEY(id)
);

