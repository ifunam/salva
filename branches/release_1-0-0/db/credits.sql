CREATE TABLE user_creditsarticles (
	id SERIAL,
	user_id int4 NOT NULL
            REFERENCES users(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
	article_id int4 NOT NULL
            REFERENCES articles(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
    other text NULL,
	PRIMARY KEY (id),
	UNIQUE (user_id, article_id)
);
COMMENT ON TABLE user_creditsarticles IS
	'Artículos producto del trabajo que se está agradeciendo';

CREATE TABLE user_creditsbookeditions (
	id SERIAL,
	user_id int4 NOT NULL
            REFERENCES users(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
	bookedition_id int4 NOT NULL
            REFERENCES bookeditions(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
    other text NULL,
	PRIMARY KEY (id),
	UNIQUE (user_id, bookedition_id)
);
COMMENT ON TABLE user_creditsbookeditions IS
	'Libros producto del trabajo que se está agradeciendo';

CREATE TABLE user_creditschapterinbooks (
	id SERIAL,
	user_id int4 NOT NULL
            REFERENCES users(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
	chapterinbook_id int4 NOT NULL
            REFERENCES chapterinbooks(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
    other text NULL,
	PRIMARY KEY (id),
	UNIQUE (user_id, chapterinbook_id)
);
COMMENT ON TABLE user_creditschapterinbooks IS
	'Capítulos en libro producto del trabajo que se está agradeciendo';

CREATE TABLE user_creditsconferencetalks (
	id SERIAL,
	user_id int4 NOT NULL
            REFERENCES users(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
	conferencetalk_id int4 NOT NULL
            REFERENCES conferencetalks(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
    other text NULL,
	PRIMARY KEY (id),
	UNIQUE (user_id, conferencetalk_id)
);
COMMENT ON TABLE user_creditsconferencetalks IS
	'Conferencias producto del trabajo que se está agradeciendo';

CREATE TABLE user_creditsgenericworks (
	id SERIAL,
	user_id int4 NOT NULL
            REFERENCES users(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
	genericwork_id int4 NOT NULL
            REFERENCES genericworks(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
    other text NULL,
	PRIMARY KEY (id),
	UNIQUE (user_id, genericwork_id)
);
COMMENT ON TABLE user_creditsgenericworks IS
	'Trabajos genéricos producto del trabajo que se está agradeciendo';
	
CREATE TABLE credittypes (
        id SERIAL NOT NULL,
        name text NOT NULL,
        moduser_id int4 NULL                 -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
        created_on timestamp DEFAULT CURRENT_TIMESTAMP,
        updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (id),
        UNIQUE (name)
);
COMMENT ON TABLE credittypes IS
		'Agradecimientos por carta, Créditos y reconocimientos por apoyo técnico, Otro';

CREATE TABLE user_credits (
	   id SERIAL,
	   user_id integer 
	       REFERENCES users(id)            
	       ON UPDATE CASCADE               
           DEFERRABLE,
  	   credittype_id int4 NOT NULL
            REFERENCES credittypes(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
	   descr text NOT NULL,
	   other text NULL,
	   year  int4 NOT NULL,
	   month  smallint NULL,
	   PRIMARY KEY (id),
       UNIQUE (user_id, credittype_id, descr, year)
);
COMMENT ON TABLE user_credits IS 
		'Agradecimientos que son diferentes a agradecimientos en artículos, libros, conferencias,etc';

