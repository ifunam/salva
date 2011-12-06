class RemoveNotNullConstraintForAmountInProjectfinancingsources < ActiveRecord::Migration
  def up
     execute "ALTER TABLE projectfinancingsources ALTER COLUMN amount DROP NOT NULL"
  end

  def down
    execute "ALTER TABLE projectfinancingsources ALTER COLUMN amount SET NOT NULL"
  end
end
