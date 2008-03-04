CREATE TABLE reviews (
    id SERIAL,
    user_id int4 NOT NULL
            REFERENCES users(id)     
            ON UPDATE CASCADE   
            ON DELETE CASCADE  
            DEFERRABLE,
    authors text NOT NULL,
	title text NOT NULL,
	published_on text NOT NULL, -- journal, book, newspaper, etc
	reviewed_work_title text NOT NULL,
	reviewed_work_publication text NULL, -- journal, book, newspaper, etc
	year int4 NOT NULL,
    month int4 NULL CHECK (month >= 1 AND month <= 12),
    other text NULL,
    moduser_id int4  NULL    	     -- Use it only to know who has
    REFERENCES users(id)             -- inserted, updated or deleted  
    ON UPDATE CASCADE                -- data into or from this table.
    DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, authors, title, year)
);
COMMENT ON TABLE reviews IS
	'Participación del usuario como autor de reseñas de artículos, libros, etc';


