DROP USER salva;
CREATE USER salva; -- User for make the transacctions

-- Privileges for the users table
REVOKE ALL ON users FROM PUBLIC;
GRANT ALL ON users TO alex;
GRANT INSERT ON users TO salva;
GRANT UPDATE ON users TO salva;
GRANT SELECT ON users TO salva;
-- Sequence Table
GRANT UPDATE ON users_id_seq TO salva;

-- Privileges for the sessions table
REVOKE ALL ON sessions FROM PUBLIC;
GRANT ALL ON sessions TO alex;
GRANT INSERT ON sessions TO salva;
GRANT UPDATE ON sessions TO salva;
GRANT SELECT ON sessions TO salva;

-- Privileges for the menu table
REVOKE ALL ON menu FROM PUBLIC;
GRANT ALL ON menu TO alex;
GRANT SELECT ON menu TO salva;

-- Privileges for the menu table
REVOKE ALL ON tree FROM PUBLIC;
GRANT ALL ON tree TO alex;
GRANT SELECT ON tree TO salva;


