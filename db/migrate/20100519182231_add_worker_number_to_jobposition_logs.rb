class AddWorkerNumberToJobpositionLogs < ActiveRecord::Migration
  def self.up
    add_column :jobposition_logs, :worker_number, :string
  end

  def self.down
    remove_column :jobposition_logs, :worker_number
  end
end
