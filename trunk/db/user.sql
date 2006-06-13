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
	'Estado de cada uno de los usuarios:
	Nuevo, Activo, Bloqueado, Archivo muerto';

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
    homepage text NULL, 
    blog text NULL, 
    calendar text NULL, 
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
	'A ser utilizado con PKI (Public Key Infraestructure)';

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
	'Grupos (tipos) de usuario del sistema:
	 SALVA, Secretaría académica, Nombre de los deptos';

CREATE TABLE accessrules (
	id serial,
 	name text NOT NULL,
 	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE accessrules IS
	'Reglas de control de accesso:
	 Global, Group, Individual';

CREATE TABLE roleingroups (
    id serial, 
    name text NOT NULL,
    descr text NULL,
    accessrule_id int4 NOT NULL 
	   REFERENCES accessrules(id)
           ON UPDATE CASCADE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
);
COMMENT ON TABLE roleingroups IS
	'Rol para cada grupo, basado en el estándar RBAC (Role Based Access Control):
         https://activerbac.turingstudio.com/trac
	 Administrador, Usuario normal, Secretarío académico, Jefe de departamento, Secretaria, etc';

CREATE TABLE usergroups (
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
    roleingroup_id int4 NOT NULL 
        REFERENCES roleingroups(id)
	ON UPDATE CASCADE
	DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (user_id, group_id, roleingroup_id)
 );
COMMENT ON TABLE usergroups IS
 	'Grupo y rol que tiene cada usuario';

CREATE TABLE permissions (
	id serial,
 	name text NOT NULL,
 	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE permissions IS
	'Permisos:
	 CRUD (Create, Read, Upgrade and Delete)';

CREATE TABLE usergroup_permissions (
	id SERIAL,
	usergroup_id int4 NOT NULL
		REFERENCES usergroups(id)
		ON UPDATE CASCADE
		DEFERRABLE,
	permission_id int4 NOT NULL
		REFERENCES permissions(id)
		ON UPDATE CASCADE
		DEFERRABLE,
 	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (id),
	UNIQUE (usergroup_id, permission_id)
);
COMMENT ON TABLE usergroup_permissions IS
	'Permisos específicos al grupo y rol:
	 CRUD (Create, Read, Upgrade and Delete)';

CREATE TABLE sessions (
    id serial NOT NULL,
    session_id character varying(255),
    data text,
    updated_at timestamp without time zone,
    PRIMARY KEY (id)
);
CREATE INDEX sessions_session_id_index ON sessions USING btree (session_id);
COMMENT ON TABLE sessions IS
 	'Almacenamiento de sesiones';
