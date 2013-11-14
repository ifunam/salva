class AddTitleEnToPeople < ActiveRecord::Migration
  def change
    add_column :people, :title_en, :string
  end
end
