INSERT INTO accessrules (name) VALUES ('Global');
INSERT INTO accessrules (name) VALUES ('Group');
INSERT INTO accessrules (name) VALUES ('Individual');
REVOKE ALL PRIVILEGES ON accessrules FROM PUBLIC;
GRANT SELECT ON  accessrules  TO PUBLIC;
REVOKE ALL PRIVILEGES ON accessrules FROM salva;
GRANT SELECT ON  accessrules  TO salva;
