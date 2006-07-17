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
    parent_id integer NULL
	REFERENCES groups(id) 
        ON UPDATE CASCADE           
        ON DELETE CASCADE           
        DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE(name, parent_id)
);
COMMENT ON TABLE groups IS
	'Grupos (tipos) de usuario del sistema:
	 Admin,SALVA, Secretaría académica, Nombre de los deptos';

CREATE TABLE roles (
    id serial, 
    name text NOT NULL,
    has_group_right BOOLEAN NOT NULL default 't',
    descr text NULL,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    UNIQUE (name)
);
COMMENT ON TABLE roles IS
	'Rol para cada grupo, basado en el estándar RBAC (Role Based Access Control):
         https://activerbac.turingstudio.com/trac
	 Administrador, Usuario normal, Secretarío académico, Jefe de departamento, Secretaria, etc';

CREATE TABLE actions (
	id serial,
 	name text NOT NULL,
 	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE actions IS
	'Permisos: List, Show, New, Edit, Purge, ...';

CREATE TABLE controllers (
	id serial,
 	name text NOT NULL,
 	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE controllers IS
	'Lista de controladores: people, address, book, etc';

CREATE TABLE roleingroups (
    id SERIAL,
    group_id int4 NOT NULL
	REFERENCES groups(id)
	ON UPDATE CASCADE
	DEFERRABLE
	DEFAULT 1,
    role_id int4 NOT NULL 
        REFERENCES roles(id)
	ON UPDATE CASCADE
	DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (group_id, role_id)
);
COMMENT ON TABLE roleingroups IS
 	'Grupo y rol que tiene cada usuario';

CREATE TABLE permissions (
	id SERIAL,
        roleingroup_id int4 NOT NULL
		REFERENCES roleingroups(id)
		ON UPDATE CASCADE
		DEFERRABLE,
        controller_id int4 NOT NULL
		REFERENCES controllers(id)
		ON UPDATE CASCADE
		DEFERRABLE,
        action_id integer[] NOT NULL,
--                REFERENCES actions(id)
--		ON UPDATE CASCADE
--		DEFERRABLE,
 	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (id),
	UNIQUE (roleingroup_id, controller_id, action_id)
);
COMMENT ON TABLE permissions IS
	'Acciones específicas al controlador y al rol';

CREATE TABLE user_roleingroups (
	id serial,
    	user_id int4 NOT NULL
		REFERENCES users(id)
        	ON UPDATE CASCADE
       		ON DELETE CASCADE
		DEFERRABLE,
    	roleingroup_id int4 NOT NULL
		REFERENCES roleingroups(id)
		ON UPDATE CASCADE
		DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (id),
	UNIQUE (user_id, roleingroup_id)
);

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

