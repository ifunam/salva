
CREATE TABLE people (
  id SERIAL,
  name varchar(50) NOT NULL default '',
  street1 varchar(70) NOT NULL default '',
  street2 varchar(70) NOT NULL default '',
  city varchar(70) NOT NULL default '',
  state char(2) NOT NULL default '',
  zip varchar(10) NOT NULL default '',
  PRIMARY KEY  (id)
 );


INSERT INTO people VALUES (1, 'Superman', '123 Somewhere', '', 'Smallville', 'KS', '123456');
