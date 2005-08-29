-- Comites tutoriales
-- Jurado de examenes sinodales
-- ...
CREATE TABLE academictesttypes (
	id serial,
	name text NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);

CREATE TABLE academictests (
	id serial,	
	title text NOT NULL,
	institution_id int4 NOT NULL 
            	REFERENCES institutions(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	academiccareer_id int4 NOT NULL 
            	REFERENCES academiccareers(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	academicdegree_id integer NOT NULL -- What degree does this thesis earn?
            REFERENCES academicdegrees(id) 
            ON UPDATE CASCADE              
            DEFERRABLE,
	academictesttype_id integer NOT NULL 
            REFERENCES academictesttypes(id) 
            ON UPDATE CASCADE              
            DEFERRABLE,
	year int4 NOT NULL,
    	month int4 NULL CHECK (month >= 1 AND month <= 12),
	moduser_id integer NOT NULL      -- It will be used only to know who has
            REFERENCES users(id) -- inserted, updated or deleted  
            ON UPDATE CASCADE    -- data into or from this table.
            DEFERRABLE,
	dbuser text DEFAULT CURRENT_USER,
	dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id)
);


-- useracademictests: Expresses the relation where the user has the testing
-- role for this work (i.e., Sinodal, Evaluador,  ...)
CREATE TABLE usersacademictests (
   id SERIAL,
   academictest_id integer NOT NULL 
            REFERENCES academictests(id)
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
   -- Sanity checks: If the user is a full system user, require the user
   -- to be filled in. Likewise for an external one.
   CHECK (user_is_internal = 't' or internaluser_id IS NOT NULL),
   CHECK (user_is_internal = 'f' or externaluser_id IS NOT NULL),
   -- By having only internal or external present, we can make this UNIQUE
   -- constraint on thesis_id and both of them, and then have unicity on
   -- (anyuser, thesis_id).
   UNIQUE (academictest_id, externaluser_id, internaluser_id)
);

-- studentacademictest: Expresses the relation where the user has the 
-- 			 learning role for this test (i.e., student)
CREATE TABLE studentsacademictests ( 
   id SERIAL,
   academictest_id integer NOT NULL 
            REFERENCES academictests(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
   user_is_internal bool, -- Is the user a full system user?
   externaluser_id integer 
            REFERENCES externalusers(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
   internaluser_id integer
            REFERENCES users(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
   dbuser text DEFAULT CURRENT_USER,
   dbtimestamp timestamp DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (id),
   UNIQUE (academictest_id, internaluser_id ),
   UNIQUE (academictest_id, externaluser_id ),
   -- Sanity checks: If the user is an full system user, require the user
   -- to be filled in. Likewise for an external one.
   CHECK (user_is_internal = 't' or internaluser_id IS NOT NULL),
   CHECK (user_is_internal = 'f' or externaluser_id IS NOT NULL)
);



