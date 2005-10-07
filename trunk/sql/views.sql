----------------------------------------
-- Users, Groups and Sessions Tables  --
---------------------------------------
CREATE VIEW userstatus_view AS
  SELECT id, userstatus
  FROM userstatus
  ORDER BY id;


CREATE VIEW groups_view AS
  SELECT id,description
  FROM groups
  ORDER BY id;

--------------------------------------
-- System catalogs                  --
--------------------------------------

CREATE VIEW countries_view AS
  SELECT id, country
  FROM countries
  ORDER BY country;

CREATE VIEW citizen_view AS
  SELECT id, citizen
  FROM countries
  ORDER BY citizen;

CREATE VIEW maritalstatus_view AS
  SELECT id, maritalstatus
  FROM maritalstatus
  ORDER BY maritalstatus;

CREATE VIEW addresstype_view AS
  SELECT id, addresstype
  FROM addresstype
  ORDER BY id;

CREATE VIEW depths_view AS
  SELECT id, depth
  FROM depths
  ORDER BY id;

CREATE VIEW categories_view AS
  SELECT id, category
  FROM categories
  ORDER BY id;

CREATE VIEW tutortype_view AS
  SELECT id, type
  FROM tutortype
  ORDER BY id;

CREATE VIEW degrees_view AS
  SELECT id, degree
  FROM degrees
  ORDER BY id;

CREATE VIEW areas_view AS
  SELECT id, area
  FROM areas
  WHERE id > '1'
  ORDER BY id;

CREATE VIEW acadplantype_view AS
  SELECT id, plantype
  FROM acadplantype
  ORDER BY id;

CREATE VIEW researcher_view AS
  SELECT id, TRIM(lastname1)||' '||TRIM(lastname2)||' '||TRIM(firstname)||', '||TRIM(title) as researcher
  FROM researcher
  ORDER BY lastname1, lastname2, firstname;

CREATE VIEW gotdegreetype_view AS
  SELECT id, type
  FROM gotdegreetype
  ORDER BY id;

CREATE VIEW projecttype_view AS
  SELECT id, projecttype
  FROM projecttype
  ORDER BY id;


-- CREATE VIEW current_periods_view AS
--  SELECT p_id, p_description
--  FROM periods
--  WHERE projecttype
--  ORDER BY p_id;
--------------------------------------
-- Help for the User                --
--------------------------------------
CREATE VIEW help_view AS
  SELECT id, name, description, example
  FROM help
  ORDER BY id;

