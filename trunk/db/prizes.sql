-------------
-- Prizes  --
-------------

CREATE TABLE prizetypes( 
	id SERIAL NOT NULL,
   	name text NOT NULL,     
   	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE prizetypes IS
	'Tipos de premio:  Medalla, diploma, económico, ...';

CREATE TABLE prizes ( 
    id SERIAL,
    title text NOT NULL,
    prizetype_id int4 NOT NULL 
            REFERENCES prizetypes(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    institution_id int4 NOT NULL
            REFERENCES institutions(id) 
            ON UPDATE CASCADE           
            DEFERRABLE,
    other text NULL,
    moduser_id int4 NULL              -- Use it only to know who has
            REFERENCES users(id)   -- inserted, updated or deleted  
            ON UPDATE CASCADE      -- data into or from this table.
            DEFERRABLE,
    PRIMARY KEY (id),
    UNIQUE (title, institution_id)
);
COMMENT ON TABLE prizes IS
	'Cada uno de los premios';
COMMENT ON COLUMN prizes.institution_id IS
	'Institución que otorga el premio';

CREATE TABLE user_prizes (
    id serial,
    year   int4 NOT NULL,
    prize_id int4 NOT NULL 
            REFERENCES prizes(id)      
            ON UPDATE CASCADE
            DEFERRABLE,
    user_id int4 NOT NULL 
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    PRIMARY KEY (id),
    UNIQUE (prize_id, user_id, year)
);
COMMENT ON TABLE user_prizes IS
	'Qué usuarios han recibido qué premios';
