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
\i seminaries.sql
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
--\i organ.sql

\i files.sql
\i jobpositions.sql
\i courses.sql
\i credits.sql
\i plan.sql
\i researchgroups.sql 
\i advice.sql
\i documents.sql
\i schoolarships.sql
\i students.sql
\i institutional_activities.sql
\i tutorial_committees.sql
