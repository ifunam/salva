\set ON_ERROR_STOP 1
-- Dependencies:
-- Mostly everything depends on catalogs, user, institutions
-- projects depends on articles, books, conferences, acadvisits
\i user.sql
\i catalogs.sql
\i institutions.sql 

\i general.sql
\i schoolinghistory.sql 
\i externalusers.sql
\i languages.sql

\i articles.sql
\i researcharea.sql 
\i conferences.sql
\i books.sql  
\i acadvisits.sql 
\i thesis.sql 
\i prizes.sql
\i grant.sql

\i newspaperarticles.sql 
\i refereedpubs.sql 
\i genericworks.sql
\i techproducts.sql 
\i activities.sql

\i projects.sql 

\i skills.sql
\i organ.sql

\i files.sql
\i jobpositions.sql
\i courses.sql
\i credits.sql
\i plan.sql
\i researchgroups.sql 
\i advice.sql

\i catalogs/groups.sql
\i catalogs/userstatuses.sql
\i catalogs/default_user.sql
\i catalogs/countries.sql
\i catalogs/states.sql
\i catalogs/cities.sql
\i catalogs/maritalstatuses.sql
\i catalogs/addresstypes.sql
\i catalogs/booktypes.sql
\i catalogs/volumes.sql
\i catalogs/mediatypes.sql
\i catalogs/publishers.sql
\i catalogs/editions.sql
\i catalogs/editionstatuses.sql
\i catalogs/roleinbooks.sql
\i catalogs/institutiontypes.sql
\i catalogs/institutiontitles.sql
\i catalogs/sectors.sql
\i catalogs/institutions.sql
\i catalogs/languages.sql
\i catalogs/publicationcategories.sql
\i catalogs/articlestatuses.sql
\i catalogs/identifications.sql
\i catalogs/migratorystatuses.sql
\i catalogs/citizenmodalities.sql
\i catalogs/degrees.sql
\i catalogs/titlemodalities.sql
\i catalogs/credentials.sql
\i catalogs/jobpositiontypes.sql
\i catalogs/roleinjobpositions.sql
\i catalogs/jobpositionlevels.sql
\i catalogs/jobpositioncategories.sql
\i catalogs/contracttypes.sql

