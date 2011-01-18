class FixOldDbAddConstraintToSchoolingsColumns < ActiveRecord::Migration
  def self.up
    #  los registros 267 y 270 no cumplen con el constraint
    # execute "update schoolings set is_studying_this = 'f' where id in (267, 270);"
    execute "ALTER TABLE schoolings ADD CONSTRAINT is_studying_or_is_finished_degree CHECK ((((is_studying_this = true) AND (is_titleholder = false)) OR ((is_studying_this = false) AND (is_titleholder IS NOT NULL))));"
  end

  def self.down
  end
end
