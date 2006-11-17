CREATE TABLE techproducttypes (
	id serial,
	name text NOT NULL,
	moduser_id int4 NULL    	     -- Use it only to know who has
	    REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
	PRIMARY KEY (id)
);
COMMENT ON TABLE techproducttypes IS
	'Tipos de producto técnico:
	Desarrollo de instrumentación, Implementación de técnicas nuevas,
	Desarrollo de nuevos dispositivos, Desarrollo de hardware, Desarrollo de
	 software, Patentes, Productos electrónicos, Productos magnéticos,
	 Audio, video, CD, Floppy, DVD, otro';

CREATE TABLE techproductstatus (
	id SERIAL,	    
	name text NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE techproductstatus IS 
	'Estado en que puede estar un producto técnico: En desarrollo, entregado, publicado, otro';

CREATE TABLE techproducts (
	id serial,
	techproducttype_id int4  NULL 
            	REFERENCES techproducttypes(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	title text NOT NULL,
	authors text NOT NULL,
	descr text NULL,
	institution_id int4  NULL
            	REFERENCES institutions(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	moduser_id integer NULL  -- It will be used only to know who has
        	REFERENCES users(id) -- inserted, updated or deleted  
            	ON UPDATE CASCADE    -- data into or from this table.
            	DEFERRABLE,
	PRIMARY KEY (id)
);
COMMENT ON TABLE techproducts IS
	'Cada uno de los productos técnicos generados';
COMMENT ON COLUMN techproducts.institution_id IS
	'Institución en la que este producto fue creado (independiente de las
	instituciones de adscripción de cada uno de sus participantes)';

CREATE TABLE techproductversions (
	id SERIAL,
	techproduct_id int4  NULL 
            	REFERENCES techproducts(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
        techproductstatus_id integer NOT NULL
	    REFERENCES techproductstatus(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
	release text NOT NULL,
	descr text NULL,
	year int4 NOT NULL,
	month int4 NULL CHECK (month>=1 AND month <=12),
	isbn text NULL,
	other text NULL,
	PRIMARY KEY (id)
);
COMMENT ON TABLE techproductversions IS 
	'Cada una de las versiones de un proucto técnico';
COMMENT ON COLUMN techproductversions.release IS 
	'Número de versión o descripción de edición';
COMMENT ON COLUMN techproductversions.isbn IS 
	'Número de registro (ISBN u otro) del producto';

CREATE TABLE techproductfinancingsource (
    id SERIAL,
    techproduct_id integer NOT NULL 
	    REFERENCES techproducts(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    financingsource_id integer NOT NULL 
	    REFERENCES institutions(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    amount integer NOT NULL,
    other text NULL,
    PRIMARY KEY (id),
    UNIQUE (techproduct_id, financingsource_id )
);
COMMENT ON TABLE techproductfinancingsource IS
	'Fuentes de financiamiento de cada producto técnico';

CREATE TABLE usertechproducts (
	id SERIAL,
	techproduct_id integer NOT NULL 
        	REFERENCES techproducts(id)
            	ON UPDATE CASCADE
            	DEFERRABLE,
	user_is_internal bool,
	externaluser_id integer 
        	REFERENCES externalusers(id)            
            	ON UPDATE CASCADE               
		DEFERRABLE,
	internaluser_id integer 
         	REFERENCES users(id)            
	        ON UPDATE CASCADE               
	        DEFERRABLE,
	userrole_id integer NULL 
        	REFERENCES userroles(id)
	        ON UPDATE CASCADE
        	DEFERRABLE,
	PRIMARY KEY (id),
	UNIQUE (techproduct_id, internaluser_id ),
	UNIQUE (techproduct_id, externaluser_id ),
	-- Sanity checks: If this is a full system user, require the user
	-- to be filled in. Likewise for an external one.
	CHECK (user_is_internal = 't' OR
		(internaluser_id IS NOT NULL AND externaluser_id IS NULL)),
	CHECK (user_is_internal = 'f' OR
		(externaluser_id IS NOT NULL AND internaluser_id IS NULL))
);
COMMENT ON TABLE usertechproducts IS
	'Productos técnicos en los que cada usuario ha estado involucrado';
COMMENT ON COLUMN usertechproducts.user_is_internal IS
	'El usuario es interno del sistema? Si sí, exigimos internaluser_id; 
	si no, exigimos externaluser_id';
