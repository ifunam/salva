class RenamePeopleIdentificatiosToUserIdentifications < ActiveRecord::Migration
  def self.up
    rename_table :people_identifications, :user_identifications
  end

  def self.down
    rename_table  :user_identifications, :people_identifications
  end
end
