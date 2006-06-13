
CREATE TABLE pubtorefereed (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY (id),
	UNIQUE(name)	
);
COMMENT ON TABLE pubtorefereed IS 
	'Tipo de publicación o *cosa* que debe arbitrarse:
	Instutional project, research project, magazine, book, article, contest, prize,';

CREATE TABLE refereedpubs(
	id serial,
	title text NOT NULL,
        pubtorefereed_id integer NOT NULL 
        	REFERENCES  pubtorefereed(id)
            	ON UPDATE CASCADE
	         DEFERRABLE,
	institution_id int4 NOT NULL 
            	REFERENCES institutions(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	moduser_id integer NULL   -- It will be used only to know who has
            REFERENCES users(id)      -- inserted, updated or deleted  
            ON UPDATE CASCADE         -- data into or from this table.
            DEFERRABLE,
	PRIMARY KEY (id)	
);
COMMENT ON TABLE refereedpubs IS
	'Actividad del arbitraje';


CREATE TABLE userrefereedpubs (
	id SERIAL,
	refereedpubs_id integer NOT NULL 
        	REFERENCES refereedpubs(id)
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
   	PRIMARY KEY (id),
	-- Sanity checks: If the user is a full system user, require the
	-- user to be filled in. Likewise for an external one.
	CHECK (user_is_internal = 't' OR
		(internaluser_id IS NOT NULL AND externaluser_id IS NULL)),
	CHECK (user_is_internal = 'f' OR
		(externaluser_id IS NOT NULL AND internaluser_id IS NULL)),
	-- By having only internal or external present, we can make this UNIQUE
	-- constraint on thesis_id and both of them, and then have unicity on
	 -- (anyuser, thesis_id).
	UNIQUE (refereedpubs_id, externaluser_id, internaluser_id)
);
COMMENT ON TABLE refereedpubs IS
	'Rol del usuario en la actividad del arbitraje';
