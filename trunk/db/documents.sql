-- 
CREATE TABLE documenttypes (
	id serial,
	name text NOT NULL,
	descr text NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE people IS
	'Tipos de documentos que se van expedir: Informe anual, plan anual, curriculum, etc';

CREATE TABLE user_documents ( 
	id serial,
	user_id int4 NOT NULL 
		REFERENCES users(id)
            	ON UPDATE CASCADE
            	ON DELETE CASCADE,
	is_published boolean NOT NULL,
	date_published date NOT NULL,
        documenttype_id int4 NOT NULL 
                REFERENCES documenttypes(id)
		ON UPDATE CASCADE
                DEFERRABLE,
	document  bytea NOT NULL,
	document_filename text NOT NULL,
        document_content_type text NOT NULL,
	ip_addr text NOT NULL,--El tipo de dato INET no esta soportado en rails
        moduser_id int4  NULL        -- Use it only to know who has
           	REFERENCES users(id) -- inserted, updated or deleted  
		ON UPDATE CASCADE    -- data into or from this table.
              DEFERRABLE,
        created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (id)
);
COMMENT ON TABLE user_documents IS
	'Documentos que ha publicado el usuario';


--	boss_id  
--	ip_address text NOT NULL,
--	approved boolean NOT NULL,                     | default false
