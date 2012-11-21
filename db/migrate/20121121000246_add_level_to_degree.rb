class AddLevelToDegree < ActiveRecord::Migration
  def change
    add_column :degrees, :level, :integer
  end
end
