--------------------
-- External users --
--------------------

-- External users are those which don't have an account in our system, probably
-- because they do not belong to our institution. We have the minimum needed
-- information for referring to them wherever we need them.

CREATE TABLE externaluserlevels ( 
	id SERIAL,
	name text NOT NULL, 
	UNIQUE (name),
  	PRIMARY KEY (id)
);	
COMMENT ON TABLE externaluserlevels IS
	'Nivel de una persona (usuario externo) en su institución:
	Estudiante, Investigador, Técnico Académico, ...';

CREATE TABLE externalusers ( 
    id SERIAL,
    firstname text NOT NULL,
    lastname1 text NOT NULL,
    lastname2 text NULL,
    institution_id integer NULL 
	    REFERENCES institutions(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    externaluserlevel_id integer NULL
	    REFERENCES externaluserlevels(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    degree_id integer NULL
	    REFERENCES degrees(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    PRIMARY KEY (id)
);
COMMENT ON TABLE externalusers IS
	'Datos registrados de un usuario externo - Nombre e institución';
