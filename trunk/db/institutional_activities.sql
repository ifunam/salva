CREATE TABLE institutional_activities ( 
    id SERIAL,
    user_id int4 NOT NULL        -- Use it only to know who has
            REFERENCES users(id) -- inserted, updated or deleted  
            ON UPDATE CASCADE    -- data into or from this table.
            DEFERRABLE,
    descr text NOT NULL,
    institution_id int4 NOT NULL 
            	REFERENCES institutions(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
    startmonth int4 NULL CHECK (startmonth<=12 AND startmonth>=1),
    startyear int4 NOT NULL,
    endmonth int4 NULL CHECK (endmonth<=12 AND endmonth>=1),
    endyear  int4 NULL,
    moduser_id int4 NULL               	    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
COMMENT ON TABLE institutional_activities IS
	'Participación institucional';