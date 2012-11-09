class DropPkeyFromUserResearchlines < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE user_researchlines
      DROP CONSTRAINT user_researchlines_pkey;
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE user_researchlines
      ADD CONSTRAINT user_researchlines_pkey PRIMARY KEY(user_id , researchline_id );
    SQL
  end
end
