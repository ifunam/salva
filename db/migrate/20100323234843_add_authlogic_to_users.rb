class AddAuthlogicToUsers < ActiveRecord::Migration
  def self.up
    rename_column :users, :passwd, :crypted_password
    rename_column :users, :salt, :password_salt
    add_column :users, :persistence_token, :string
    add_column :users, :single_access_token, :string
    add_column :users, :perishable_token, :string
    add_column :users, :login_count, :integer
    add_column :users, :failed_login_count, :integer
    add_column :users, :last_request_at, :datetime
    add_column :users, :current_login_at, :datetime
    add_column :users, :last_login_at, :datetime
    add_column :users, :current_login_ip, :string
    add_column :users, :last_login_ip, :string
  end

  def self.down
    [ :persistence_token, :single_access_token, :perishable_token, :login_count, :failed_login_count,
      :last_request_at, :current_login_at, :last_login_at, :current_login_ip, :last_login_ip ].each do |column_name|
        remove_column :users, column_name
    end
    rename_column :users, :crypted_password, :passwd
    rename_column :users, :password_salt, :salt
  end
end
