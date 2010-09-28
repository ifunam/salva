class RemovingStartyearConstraintInJobpositionlog < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE jobpositionlog ALTER COLUMN startyear DROP NOT NULL;"
  end

  def self.down
    execute "ALTER TABLE jobpositionlog ALTER COLUMN startyear SET NOT NULL;"
  end
end
