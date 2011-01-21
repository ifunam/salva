class FixOldDbAddConstraintToEducationsColumns < ActiveRecord::Migration
  def self.up
    #  los registros 267 y 270 no cumplen con el constraint
    # execute "update schoolings set is_studying_this = 'f' where id in (267, 270);"
    pg_result = execute("SELECT conname FROM pg_constraint WHERE conname = 'is_studying_or_is_finished_degree'")
    if pg_result.ntuples == 0
      execute "ALTER TABLE educations ADD CONSTRAINT is_studying_or_is_finished_degree CHECK ((((is_studying_this = true) AND (is_titleholder = false)) OR ((is_studying_this = false) AND (is_titleholder IS NOT NULL))));"
    end
  end

  def self.down
  end
end
