class AddPhoneExtensionToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :phone_extension, :string
  end
end
