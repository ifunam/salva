# encoding: utf-8
require 'csv'
data_dir = Rails.root.join('db', 'data')

[Userstatus, Group].each do |class_name|
  class_name.destroy_all
  CSV.foreach(File.join(data_dir, "#{ActiveSupport::Inflector.tableize(class_name)}.csv"), :headers => false) do |row|
    class_name.create name: row[0].to_s.strip
  end
end

