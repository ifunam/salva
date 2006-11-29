CREATE TABLE studentroles (
	id serial PRIMARY KEY,
	name text NOT NULL UNIQUE,
	moduser_id int4 NULL    -- Use it only to know who has
        REFERENCES users(id)    -- inserted, updated or deleted  
        ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
    	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    	updated_on timestamp DEFAULT CURRENT_TIMESTAMP
	
);

CREATE TABLE student_activities (
	id serial PRIMARY KEY,
	user_id int4 NULL    -- Use it only to know who has
        REFERENCES users(id)    -- inserted, updated or deleted  
        ON UPDATE CASCADE       -- data into or from this table.
	ON DELETE CASCADE
        DEFERRABLE,
	schooling_id int4 NULL    -- Use it only to know who has
        REFERENCES schoolings(id)    -- inserted, updated or deleted  
        ON UPDATE CASCADE       -- data into or from this table.
	ON DELETE CASCADE
        DEFERRABLE,
	studentroles_id int4 NULL    -- Use it only to know who has
        REFERENCES studentroles(id)    -- inserted, updated or deleted  
        ON UPDATE CASCADE       -- data into or from this table.
	ON DELETE CASCADE
        DEFERRABLE,
	tutor_is_internal bool, 
	tutor_user_id integer NULL
        REFERENCES users(id)
        ON UPDATE CASCADE               
        DEFERRABLE,
	tutor_externaluser_id integer NULL
	REFERENCES externalusers(id)            
	ON UPDATE CASCADE               
	DEFERRABLE,
	moduser_id int4 NULL    -- Use it only to know who has
        REFERENCES users(id)    -- inserted, updated or deleted  
        ON UPDATE CASCADE       -- data into or from this table.
        DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	UNIQUE (user_id, tutor_user_id ),
	UNIQUE (user_id, tutor_externaluser_id ),
	-- Sanity checks: If the user is an full system user, require the user
	-- to be filled in. Likewise for an external one.
	CHECK (tutor_is_internal = 't' AND tutor_user_id IS NOT NULL AND tutor_externaluser_id IS NULL),
	CHECK (tutor_is_internal = 'f' AND tutor_user_id IS  NULL AND tutor_externaluser_id IS NOT NULL)
);

CREATE TABLE schooling_filetypes (
	id serial PRIMARY KEY,
	name text NOT NULL UNIQUE,
	descr text NULL,
	moduser_id int4 NULL    -- Use it only to know who has
        REFERENCES users(id)    -- inserted, updated or deleted  
        ON UPDATE CASCADE       -- data into or from this table.
        DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	UNIQUE (name)
);

CREATE TABLE schooling_files (
	id serial PRIMARY KEY,
	schooling_id int4 NOT NULL references schoolings(id) ON DELETE CASCADE ON UPDATE CASCADE,
	schooling_filetype_id int4 NOT NULL references schooling_filetypes(id) ON DELETE CASCADE ON UPDATE CASCADE,
	filename text NOT NULL,
	content_type text NULL,
	content bytea NOT NULL,
	moduser_id int4 NULL    -- Use it only to know who has
        REFERENCES users(id)    -- inserted, updated or deleted  
        ON UPDATE CASCADE       -- data into or from this table.
        DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	UNIQUE (schooling_id,schooling_filetype_id)
);
