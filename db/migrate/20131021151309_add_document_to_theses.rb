class AddDocumentToTheses < ActiveRecord::Migration
  def change
    add_column :theses, :document, :string
  end
end
