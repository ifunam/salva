class AddDeviseToUsers < ActiveRecord::Migration
  def self.up
    # Removing authlogic columns  
    [ :persistence_token, :single_access_token, :perishable_token, :login_count, :failed_login_count,
      :last_request_at, :current_login_at, :last_login_at, :current_login_ip, :last_login_ip ].each do |column_name|
      if column_exists? :users, column_name
        remove_column :users, column_name
      end
    end
  
    if column_exists? :users, :crypted_password
      rename_column :users, :crypted_password, :encrypted_password
    end

    ["reset_password_token", "remember_token", "current_sign_in_ip", "last_sign_in_ip" ].each do |field_name|
      unless column_exists? :users, field_name
        add_column :users, field_name.to_sym, :string
      end
    end

    ["remember_created_at", "current_sign_in_at", "last_sign_in_at", ].each do |field_name|
      unless column_exists? :users, field_name
        add_column :users, field_name.to_sym, :datetime
      end
    end

    unless column_exists? :users, :sign_in_count
      add_column :users, :sign_in_count, :integer,:default => 0
    end

  end


  def self.down
      rename_column :users, :encrypted_password, :crypted_password
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
    ["reset_password_token", "remember_token", "current_sign_in_ip", "last_sign_in_ip" ].each do |field_name|
      remove_column :users, field_name.to_sym
    end
    ["remember_created_at", "current_sign_in_at", "last_sign_in_at", :sign_in_count ].each do |field_name|
        remove_column :users, field_name.to_sym
    end
  end
 end
