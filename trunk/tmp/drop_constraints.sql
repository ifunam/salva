ALTER TABLE articles DROP CONSTRAINT articles_title_key;
ALTER TABLE projects DROP CONSTRAINT projects_name_key;
ALTER TABLE institutions DROP CONSTRAINT institutions_name_key;
ALTER TABLE seminaries DROP CONSTRAINT seminaries_title_key;
ALTER TABLE conferences DROP CONSTRAINT conferences_name_key;
ALTER TABLE stimulustypes DROP CONSTRAINT stimulustypes_name_key;
ALTER TABLE stimuluslevels DROP CONSTRAINT stimuluslevels_name_key;
ALTER TABLE user_prizes DROP CONSTRAINT user_prizes_prize_id_key;
ALTER TABLE prizes DROP CONSTRAINT prizes_name_key;
ALTER TABLE bookedition_roleinbooks DROP CONSTRAINT bookedition_roleinbooks_user_id_key;
ALTER TABLE bookeditions DROP CONSTRAINT bookeditions_book_id_key;
ALTER TABLE books DROP CONSTRAINT books_title_key;
ALTER TABLE chapterinbooks DROP CONSTRAINT chapterinbooks_bookedition_id_key;
ALTER TABLE chapterinbook_roleinchapters DROP CONSTRAINT chapterinbook_roleinchapters_user_id_key;

