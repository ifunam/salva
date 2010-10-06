class RemovingNotNullConstraintsInDocuments < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE documents ALTER COLUMN documenttype_id DROP NOT NULL;"
    execute "ALTER TABLE documents ALTER COLUMN title DROP NOT NULL;"
    execute "ALTER TABLE documents ALTER COLUMN startdate DROP NOT NULL;"
    execute "ALTER TABLE documents ALTER COLUMN enddate DROP NOT NULL;"
  end

  def self.down
        execute "ALTER TABLE documents ALTER COLUMN documenttype_id SET NOT NULL;"
    execute "ALTER TABLE documents ALTER COLUMN title SET NOT NULL;"
    execute "ALTER TABLE documents ALTER COLUMN startdate SET NOT NULL;"
    execute "ALTER TABLE documents ALTER COLUMN enddate SET NOT NULL;"
  end
end
