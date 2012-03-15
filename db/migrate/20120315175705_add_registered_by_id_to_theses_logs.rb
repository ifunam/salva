class AddRegisteredByIdToThesesLogs < ActiveRecord::Migration
  def change
    if column_exists? :theses_logs, :moduser_id
      rename_column :theses_logs, :moduser_id, :registered_by_id
    else
      add_column :theses_logs, :registered_by_id, :integer
    end

    unless column_exists? :theses_logs, :modified_by_id
      add_column :theses_logs, :modified_by_id, :integer
    end
  end
end
