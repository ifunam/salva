class AddHasOpenAccessToJournals < ActiveRecord::Migration
  def change
    add_column :journals, :has_open_access, :boolean
  end
end
