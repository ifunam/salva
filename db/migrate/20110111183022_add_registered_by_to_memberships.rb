class AddRegisteredByToMemberships < ActiveRecord::Migration
  def self.up
    if column_exists? :memberships, :moduser_id
      rename_column :memberships, :moduser_id, :registered_by_id
    else
      add_column    :memberships, :registered_by_id, :integer
    end
    add_column :memberships, :modified_by_id, :integer
  end

  def self.down
    if column_exists? :memberships, :moduser_id
      remove_column :memberships, :moduser_id
    end

    if column_exists? :memberships, :registered_by_id
      rename_column :memberships, :registered_by_id, :moduser_id
    end

    if column_exists? :memberships, :modified_by_id
      remove_column :memberships, :modified_by_id
    end
  end
end
