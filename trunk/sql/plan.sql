CREATE TABLE plan (
    id SERIAL,
    uid int4 NOT NULL
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    plan text NOT NULL,
    extendedinfo bytea NULL,
    year int4 NOT NULL,
    PRIMARY KEY (id)
);
COMMENT ON TABLE plan IS
	'Plan de trabajo anual - Permite adjuntar un archivo binario';

CREATE TABLE selfevaluation (
    id SERIAL,
    uid int4 NOT NULL
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    plan text NOT NULL,
    year int4 NOT NULL,
    PRIMARY KEY (id)
);
COMMENT ON TABLE selfevaluation IS
	'Auto-evaluación anual';
