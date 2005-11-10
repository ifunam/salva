------------------------------------
-- User status and Groups Tables  --
------------------------------------
CREATE TABLE userstatuses ( 
    id serial NOT NULL,
    name text NOT NULL,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE(name)
);
COMMENT ON TABLE userstatuses IS
	'Estado de cada uno de los usuarios';
-- Nuevo, aprobado, bloqueado, etc.

CREATE TABLE groups (
    id serial NOT NULL,
    name text NOT NULL,
    descr text NULL,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE(name)
);
COMMENT ON TABLE groups IS
	'Grupos (tipos) de usuario del sistema';
-- Usuario, operador, administrador, etc.

CREATE TABLE permissions (
    id serial, 
    name text NOT NULL,
    descr text NULL,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
);

CREATE TABLE groups_permissions (
    id serial,
    group_id int4 NOT NULL 
           REFERENCES groups(id)
           ON UPDATE CASCADE,
    permission_id int4 NOT NULL 
           REFERENCES permissions(id)
           ON UPDATE CASCADE,
    PRIMARY KEY(id),
    UNIQUE (group_id, permission_id)
);
CREATE INDEX gp_map_idx ON groups_permissions USING btree (group_id, permission_id);


CREATE TABLE users ( 
    id SERIAL NOT NULL,
    login text NOT NULL,
    passwd text NOT NULL,
    salt text NULL,
    userstatus_id int4 NOT NULL 
            REFERENCES userstatuses(id)
            ON UPDATE CASCADE
            DEFERRABLE
	    DEFAULT 1,
    email text NULL, 
    pkcs7 text NULL,
    token text NULL,
    token_expiry timestamp DEFAULT CURRENT_TIMESTAMP,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE(login)
);
CREATE INDEX users_id_idx ON users(id);
CREATE INDEX users_name_idx ON users(login);
COMMENT ON TABLE users IS
	'Usuarios del sistema';
COMMENT ON COLUMN users.email IS 
	'El correo será utilizado para la recuperación de contraseñas o 
	notificación de cambios generados por terceros';
COMMENT ON COLUMN users.pkcs7 IS 
	'A ser utilizado con infraestructura PKI';

CREATE TABLE users_groups (
    id SERIAL,
    user_id int4 NOT NULL
	REFERENCES users(id)
        ON UPDATE CASCADE
       	ON DELETE CASCADE
	DEFERRABLE,
    group_id int4 NOT NULL
	REFERENCES groups(id)
	ON UPDATE CASCADE
	DEFERRABLE
	DEFAULT 1,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, group_id)
 );
COMMENT ON TABLE users_groups IS
 	'Grupos a los que pertenece cada usuario';
