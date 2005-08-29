
-- Project, magazine, etc..
CREATE TABLE thingtoarbitrate (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY (id),
	UNIQUE(name)	
);

CREATE TABLE arbitrations (
	id serial,
	title text NOT NULL,
	thingtoarbitrate_id integer NOT NULL 
        	REFERENCES thingtoarbitrate(id)
            	ON UPDATE CASCADE
	         DEFERRABLE,
	institution_id int4 NOT NULL 
            	REFERENCES institutions(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	moduser_id integer NOT NULL   -- It will be used only to know who has
            REFERENCES users(id)      -- inserted, updated or deleted  
            ON UPDATE CASCADE         -- data into or from this table.
            DEFERRABLE,
	dbuser text DEFAULT CURRENT_USER,
	dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id)	
);


CREATE TABLE usersarbitrations (
	id SERIAL,
	arbitration_id integer NOT NULL 
        	REFERENCES arbitrations(id)
            	ON UPDATE CASCADE
	        DEFERRABLE,
	userrole integer NOT NULL -- What is the user's role?
            	REFERENCES userrole(id)
            	ON UPDATE CASCADE
            	DEFERRABLE,
	user_is_internal bool, -- Is the user a full system user?
   	externaluser_id integer NULL 
        	REFERENCES externalusers(id)            
            	ON UPDATE CASCADE               
            	DEFERRABLE,
	internaluser_id integer NULL
            REFERENCES users(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
	dbuser text DEFAULT CURRENT_USER,
	dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
   	PRIMARY KEY (id),
	-- Sanity checks: If the user is a full system user, require the
	-- user to be filled in. Likewise for an external one.
	CHECK (user_is_internal = 't' or internaluser_id IS NOT NULL),
	CHECK (user_is_internal = 'f' or externaluser_id IS NOT NULL),
	-- By having only internal or external present, we can make this UNIQUE
	-- constraint on thesis_id and both of them, and then have unicity on
	 -- (anyuser, thesis_id).
	UNIQUE (arbitration_id, externaluser_id, internaluser_id)
);