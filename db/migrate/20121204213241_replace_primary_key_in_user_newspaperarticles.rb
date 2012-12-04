class ReplacePrimaryKeyInUserNewspaperarticles < ActiveRecord::Migration
  def up
    execute "ALTER TABLE user_newspaperarticles DROP CONSTRAINT user_newspaperarticles_pkey"
    record = UserNewspaperarticle.find_by_sql("SELECT id FROM user_newspaperarticles ORDER BY id DESC LIMIT 1").first
    index = record.nil? ? 1 : (record.id + 1)
    execute "ALTER SEQUENCE user_newspaperarticles_id_seq RESTART WITH #{index}"
    UserNewspaperarticle.all.each do |record|
      execute "UPDATE user_newspaperarticles SET id = #{index} WHERE id = #{record.id} AND user_id = #{record.user_id} AND newspaperarticle_id = #{record.newspaperarticle_id}"
      index += 1
    end
    execute "ALTER SEQUENCE user_newspaperarticles_id_seq RESTART WITH #{index+1}"
    execute "ALTER TABLE user_newspaperarticles ADD PRIMARY KEY (id)"
  end

  def down
    execute "DROP INDEX user_newspaperarticles_pkey"
    execute "ALTER TABLE user_newspaperarticles ADD PRIMARY KEY (user_id, newspaperarticle_id)"
  end

end
