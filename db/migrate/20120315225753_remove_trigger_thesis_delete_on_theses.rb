class RemoveTriggerThesisDeleteOnTheses < ActiveRecord::Migration
  def up
    execute "DROP TRIGGER IF EXISTS thesis_delete ON theses"
  end

  def down
    execute "CREATE TRIGGER thesis_delete AFTER DELETE ON theses FOR EACH ROW EXECUTE PROCEDURE thesis_delete()"
  end
end
