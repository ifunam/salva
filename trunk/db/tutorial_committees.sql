CREATE TABLE tutorial_committees (
	id SERIAL NOT NULL,
	student text NOT NULL,
    	descr text NULL,
    	degree_id integer NOT NULL
            REFERENCES degrees(id) 
            ON UPDATE CASCADE              
            DEFERRABLE,
	institutioncareer_id int4 NOT NULL 
            REFERENCES institutioncareers(id)       
            ON UPDATE CASCADE
            DEFERRABLE,
	year int4 NOT NULL,
        other text NULL,
        moduser_id int4 NULL               	    -- Use it to known who
        REFERENCES users(id)            -- has inserted, updated or deleted
        ON UPDATE CASCADE               -- data into or  from this table.
        DEFERRABLE,
        created_on timestamp DEFAULT CURRENT_TIMESTAMP,
        updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id)
);
COMMENT ON TABLE theses IS 
	'Participación en comités tutorales';
COMMENT ON COLUMN theses.degree_id IS
	'Grado académico que esta tesis persigue';
