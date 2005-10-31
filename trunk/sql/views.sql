-- table_attributes: Which attributes are available in each table
-- Get their name, datatype, if they accept null values and description.
CREATE OR REPLACE VIEW table_attributes AS 
SELECT c.relname AS tablename, a.attname AS attrname, t.typname AS type, 
	a.attnotnull AS required, d.description AS description 
FROM pg_class c JOIN pg_attribute a ON a.attrelid=c.oid JOIN pg_type t ON 
	a.atttypid=t.oid LEFT OUTER JOIN pg_description d ON d.objoid=c.oid 
	AND d.objsubid=a.attnum 
WHERE a.attnum>0 AND a.attisdropped = 'f' AND c.relkind='r' AND c.relnamespace 
	NOT IN (SELECT oid FROM pg_namespace WHERE nspname IN ('pg_catalog', 
		'information_schema'))
ORDER BY tablename, a.attnum;

-- tables: The list of tables in the system, with their description if 
-- available
CREATE OR REPLACE VIEW tables AS 
SELECT c.relname AS tablename, d.description AS description 
FROM pg_class c LEFT OUTER JOIN pg_description d ON d.objoid=c.oid AND 
	d.objsubid = 0
WHERE relkind='r' AND relnamespace NOT IN (
	SELECT oid FROM pg_namespace WHERE nspname IN (
		'pg_catalog', 'information_schema')
	)
ORDER BY relname;

-- related_tables: Gets the relationship between different tables
CREATE OR REPLACE VIEW related_tables AS
SELECT c1.relname AS referrer, c2.relname AS refered, a.attname AS ref_key
FROM pg_constraint con JOIN pg_class c1 ON con.conrelid=c1.oid JOIN pg_class c2
	ON con.confrelid=c2.oid JOIN pg_attribute a ON c1.oid=a.attrelid AND
	a.attnum=ANY(con.conkey) 
WHERE contype='f' 
ORDER BY c1.relname, c2.relname;

---- 
---- Old cruft. Is this / can this still be useful?
----
--
-- ----------------------------------------
-- -- Users, Groups and Sessions Tables  --
-- ---------------------------------------
-- CREATE VIEW userstatus_view AS
--   SELECT id, userstatus
--   FROM userstatus
--   ORDER BY id;


-- CREATE VIEW groups_view AS
--   SELECT id,description
--   FROM groups
--   ORDER BY id;

-- --------------------------------------
-- -- System catalogs                  --
-- --------------------------------------

-- CREATE VIEW countries_view AS
--   SELECT id, country
--   FROM countries
--   ORDER BY country;

-- CREATE VIEW citizen_view AS
--   SELECT id, citizen
--   FROM countries
--   ORDER BY citizen;

-- CREATE VIEW maritalstatus_view AS
--   SELECT id, maritalstatus
--   FROM maritalstatus
--   ORDER BY maritalstatus;

-- CREATE VIEW addresstype_view AS
--   SELECT id, addresstype
--   FROM addresstype
--   ORDER BY id;

-- CREATE VIEW depths_view AS
--   SELECT id, depth
--   FROM depths
--   ORDER BY id;

-- CREATE VIEW categories_view AS
--   SELECT id, category
--   FROM categories
--   ORDER BY id;

-- CREATE VIEW tutortype_view AS
--   SELECT id, type
--   FROM tutortype
--   ORDER BY id;

-- CREATE VIEW degrees_view AS
--   SELECT id, degree
--   FROM degrees
--   ORDER BY id;

-- CREATE VIEW areas_view AS
--   SELECT id, area
--   FROM areas
--   WHERE id > '1'
--   ORDER BY id;

-- CREATE VIEW acadplantype_view AS
--   SELECT id, plantype
--   FROM acadplantype
--   ORDER BY id;

-- CREATE VIEW researcher_view AS
--   SELECT id, TRIM(lastname1)||' '||TRIM(lastname2)||' '||TRIM(firstname)||', '||TRIM(title) as researcher
--   FROM researcher
--   ORDER BY lastname1, lastname2, firstname;

-- CREATE VIEW gotdegreetype_view AS
--   SELECT id, type
--   FROM gotdegreetype
--   ORDER BY id;

-- CREATE VIEW projecttype_view AS
--   SELECT id, projecttype
--   FROM projecttype
--   ORDER BY id;


-- -- CREATE VIEW current_periods_view AS
-- --  SELECT p_id, p_description
-- --  FROM periods
-- --  WHERE projecttype
-- --  ORDER BY p_id;
-- --------------------------------------
-- -- Help for the User                --
-- --------------------------------------
-- CREATE VIEW help_view AS
--   SELECT id, name, description, example
--   FROM help
--   ORDER BY id;

