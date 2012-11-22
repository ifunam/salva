class RemovingNotNullConstraintsInThesesLogs < ActiveRecord::Migration
  def up
     execute "ALTER TABLE theses_logs ALTER COLUMN startyear DROP NOT NULL;"
  end

  def down
     execute "ALTER TABLE theses_logs ALTER COLUMN startyear SET NOT NULL;"
  end
end
