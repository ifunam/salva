class UpdateRecordsWithDuplicateIdFromUserResearchlines < ActiveRecord::Migration
  def up
    if UserResearchline.count > 0
      prev_id = 0
      last_id = UserResearchline.order("id DESC").first.id
      puts last_id
      UserResearchline.order("id ASC").each{ |u|
        if prev_id == u.id
          puts "DUPLICATED #{u.id}"
          last_id = last_id + 1
          execute "UPDATE user_researchlines SET id=#{last_id} WHERE id=#{u.id} AND user_id=#{u.user_id} AND researchline_id=#{u.researchline_id};"
        else
          prev_id = u.id
        end
      }
      execute "ALTER SEQUENCE user_researchlines_id_seq RESTART WITH #{last_id}";
    end
  end

  def down
  end
end
