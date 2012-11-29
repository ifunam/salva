class AddPkeyToUserResearchlines < ActiveRecord::Migration
  def up
    execute <<-SQL
          ALTER TABLE user_researchlines
          ADD CONSTRAINT user_researchlines_pkey PRIMARY KEY(id);
        SQL
  end

  def down
    execute <<-SQL
         ALTER TABLE user_researchlines
         DROP CONSTRAINT user_researchlines_pkey;
       SQL
  end
end
