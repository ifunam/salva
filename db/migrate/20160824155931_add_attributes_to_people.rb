class AddAttributesToPeople < ActiveRecord::Migration
  def change
    add_column :people, :contact_name_1, :string
    add_column :people, :contact_phonenumber_1, :string
    add_column :people, :contact_name_2, :string
    add_column :people, :contact_phonenumber_2, :string
    add_column :people, :contact_name_3, :string
    add_column :people, :contact_phonenumber_3, :string
    add_column :people, :medical_condition, :text
    add_column :people, :medical_instruction, :text
    add_column :people, :hospital, :text
    add_column :people, :insurance, :text
  end
end
