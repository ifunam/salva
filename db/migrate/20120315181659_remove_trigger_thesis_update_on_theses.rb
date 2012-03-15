class RemoveTriggerThesisUpdateOnTheses < ActiveRecord::Migration
  def up
    execute "DROP TRIGGER IF EXISTS thesis_update ON theses"
  end

  def down
    execute "CREATE TRIGGER thesis_update BEFORE UPDATE ON theses FOR EACH ROW EXECUTE PROCEDURE thesis_update()"
  end
end
