class AddUrlToTheses < ActiveRecord::Migration
  def change
    add_column :theses, :url, :string
  end
end
