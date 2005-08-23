CREATE TABLE snilevel (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);

CREATE TABLE snistatus (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);

CREATE TABLE sni (
	id SERIAL,
	uid int4 NOT NULL 
            REFERENCES users(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
	datestatus int4 NULL,
	snilevel_id smallint NOT NULL 
                         REFERENCES snilevel(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
	snistatus_id smallint NOT NULL 
                         REFERENCES snistatus(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
	notes text NULL,
	PRIMARY KEY (id),
	UNIQUE (uid, snilevel_id)
);
	