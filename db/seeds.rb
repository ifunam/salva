# encoding: utf-8
require 'csv'
data_dir = Rails.root.join('db', 'data')

[Userstatus, Group, Articlestatus, Bookchaptertype, Booktype, Citizenmodality, Conferencescope, Conferencetype,
 Contracttype, Courseduration, Coursegrouptype, Credittype, DocumentType, Editionstatus, Genericworkstatus,
 Groupmodality, Idtype, Migratorystatus].each do |class_name|
   class_name.destroy_all
   table_name = ActiveSupport::Inflector.tableize(class_name)
   puts "Inserting data into the table: #{table_name}..."
   CSV.foreach(File.join(data_dir, "#{table_name}.csv"), :headers => false) do |row|
     class_name.create name: row[0].to_s.strip
   end
end

Degree.destroy_all
puts "Inserting data into the table: degrees..."
CSV.foreach(File.join(data_dir, "degrees.csv"), :headers => false) do |row|
  Degree.create name: row[0].to_s.strip, level: row[1].to_i
end

