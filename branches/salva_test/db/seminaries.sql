CREATE TABLE seminaries ( 
    id SERIAL,
    title text NOT NULL,
    isseminary BOOLEAN NOT NULL default 't',
    url text NULL,
    month int4 NULL CHECK (month >= 1 AND month <= 12),
    year  int4 NOT NULL,
    institution_id int4 NOT NULL 
            REFERENCES institutions(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    location text NULL,
    moduser_id int4 NOT NULL                 -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (title, year, institution_id)
);
COMMENT ON TABLE seminaries IS
	'Seminarios y conferencias';
COMMENT ON COLUMN conferences.location IS
	'Lugar donde se impartio el seminario o conferencia';

CREATE TABLE roleinseminaries ( 
        id SERIAL,
        name text NOT NULL, 
        PRIMARY KEY(id),
	UNIQUE (name)
);

CREATE TABLE user_seminaries ( 
    id SERIAL,
    seminary_id int4 NOT NULL 
            REFERENCES seminaries(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    user_id int4 NOT NULL 
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    roleinseminary_id int4 NOT NULL 
            REFERENCES roleinseminaries(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    moduser_id int4                          -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id, seminary_id, roleinseminary_id),
    PRIMARY KEY (id)
);
COMMENT ON TABLE user_seminaries IS
	'Usuarios que asistieron a un seminario o conferencia';
