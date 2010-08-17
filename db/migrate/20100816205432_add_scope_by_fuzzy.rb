class AddScopeByFuzzy < ActiveRecord::Migration
  
  def self.up
    execute "SET search_path = public;"

    execute "CREATE OR REPLACE FUNCTION levenshtein (text,text) RETURNS int AS '$libdir/fuzzystrmatch','levenshtein'  LANGUAGE C IMMUTABLE STRICT;"

    execute "CREATE OR REPLACE FUNCTION levenshtein (text,text,int,int,int) RETURNS int AS '$libdir/fuzzystrmatch','levenshtein_with_costs' LANGUAGE C IMMUTABLE STRICT;"

    execute "CREATE OR REPLACE FUNCTION metaphone (text,int) RETURNS text AS '$libdir/fuzzystrmatch','metaphone'LANGUAGE C IMMUTABLE STRICT;"

    execute "CREATE OR REPLACE FUNCTION soundex(text) RETURNS text AS '$libdir/fuzzystrmatch', 'soundex' LANGUAGE C IMMUTABLE STRICT;"

    execute "CREATE OR REPLACE FUNCTION text_soundex(text) RETURNS text AS '$libdir/fuzzystrmatch', 'soundex' LANGUAGE C IMMUTABLE STRICT;"

    execute "CREATE OR REPLACE FUNCTION difference(text,text) RETURNS int AS '$libdir/fuzzystrmatch', 'difference' LANGUAGE C IMMUTABLE STRICT;"

    execute "CREATE OR REPLACE FUNCTION dmetaphone (text) RETURNS text AS '$libdir/fuzzystrmatch', 'dmetaphone' LANGUAGE C IMMUTABLE STRICT;"

    execute "CREATE OR REPLACE FUNCTION dmetaphone_alt (text) RETURNS text AS '$libdir/fuzzystrmatch', 'dmetaphone_alt' LANGUAGE C IMMUTABLE STRICT;"
  end
  
  def self.down
    execute "SET search_path = public;"

    execute "DROP FUNCTION dmetaphone_alt (text);"

    execute "DROP FUNCTION dmetaphone (text);"

    execute "DROP FUNCTION difference(text,text);"

    execute "DROP FUNCTION text_soundex(text);"

    execute "DROP FUNCTION soundex(text);"

    execute "DROP FUNCTION metaphone (text,int);"

    execute "DROP FUNCTION levenshtein (text,text,int,int,int);"

    execute "DROP FUNCTION levenshtein (text,text);"
  end
end