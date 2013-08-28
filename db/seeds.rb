# encoding: utf-8
require 'csv'
data_dir = Rails.root.join('db', 'data')

[Userstatus, Group, Articlestatus, Bookchaptertype, Booktype, Citizenmodality, Conferencescope, Conferencetype,
 Contracttype, Courseduration, Coursegrouptype, Credittype, DocumentType, Editionstatus, Genericworkstatus,
 Groupmodality, Idtype, Migratorystatus].each do |class_name|
   table_name = ActiveSupport::Inflector.tableize(class_name)
   puts "Inserting data into the table: #{table_name}..."
   CSV.foreach(File.join(data_dir, "#{table_name}.csv"), headers: false) do |row|
     class_name.where(name: row[0].to_s.strip).first_or_create
   end
end

puts "Inserting data into the table: degrees..."
CSV.foreach(File.join(data_dir, "degrees.csv"), headers: false) do |row|
  Degree.where(name: row[0].to_s.strip, level: row[1].to_i).first_or_create
end

