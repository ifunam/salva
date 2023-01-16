# encoding: utf-8
require 'csv'
require 'highline/import'
data_dir = Rails.root.join('db', 'data')

[Group, Articlestatus, Bookchaptertype, Booktype, Citizenmodality, Conferencescope, Conferencetype,
 Contracttype, Courseduration, Coursegrouptype, Credittype, DocumentType, Editionstatus, Genericworkstatus,
 Groupmodality, Idtype, Migratorystatus, Maritalstatus, DocumentType, Jobpositiontype, Jobpositionlevel,
 Roleinjobposition, Institutiontype, Institutiontitle].each do |class_name|
   table_name = ActiveSupport::Inflector.tableize(class_name.to_s )
   puts "Inserting data into the table: #{table_name}..."
   CSV.foreach(File.join(data_dir, "#{table_name}.csv"), headers: false) do |row|
    name = row[0].to_s.strip
     class_name.create(name: name)
   end
end

puts "Inserting data into the table: degrees..."
CSV.foreach(File.join(data_dir, "degrees.csv"), headers: false) do |row|
  Degree.where(name: row[0].to_s.strip, level: row[1].to_i).first_or_create
end

puts "Inserting data into the table: countries..."
CSV.foreach(File.join(data_dir, "countries.csv"), headers: false) do |row|
  Country.where(name: row[0].to_s.strip, citizen: row[1].to_s.strip, :code => row[2].to_s.strip, :id => row[3].to_i).first_or_create
end

puts "Inserting data into the table: states..."
CSV.foreach(File.join(data_dir, "states.csv"), headers: false) do |row|
  State.where(name: row[0].to_s.strip, code: row[1].to_s.strip, :country_id => row[2].to_i).first_or_create
end

puts "Inserting data into the table: cities..."
CSV.foreach(File.join(data_dir, "cities.csv"), headers: false) do |row|
  City.where(name: row[0].to_s.strip, state_id: row[1].to_i).first_or_create
end

puts "Inserting data into the table: documenttypes..."
CSV.foreach(File.join(data_dir, "documenttypes.csv"), headers: false) do |row|
  Documenttype.where(name: row[0].to_s.strip, year: row[1].to_i, status: (row[2].to_s == 't'), start_date: row[3], end_date: row[4]).first_or_create
end

puts "Inserting data into the table: jobpositioncategories..."
CSV.foreach(File.join(data_dir, "jobpositioncategories.csv"), headers: false) do |row|
  Jobpositioncategory.where(jobpositiontype_id: row[0].to_i, jobpositionlevel_id: row[1].to_i, roleinjobposition_id: row[2].to_i, administrative_key: row[3].to_s.strip).first_or_create
end

puts "Inserting data into the table: institutions..."
CSV.foreach(File.join(data_dir, "institutions.csv"), headers: false) do |row|
  @i = Institution.where(name: row[0].to_s.strip, url: row[1].to_s, institutiontype_id: row[2].to_i, country_id: row[3].to_i, administrative_key: row[4], institution_id: row[5].to_i, institutiontitle_id: Institutiontitle.first.id).first_or_create
end

puts "Inserting data into the table: periods"
CSV.foreach(File.join(data_dir, "periods.csv"), headers: false) do |row|
  Period.where(title: row[0].to_s.strip, startdate: row[1], enddate: row[2]).first_or_create
end


# unless User.exists? :login => 'admin'
#   puts "Creating the 'admin' user account"
#   while (1) do
#     password = ask("Enter password: ") { |q| q.echo = false }
#     password_confirmation = ask("Enter password confirmation: ") { |q| q.echo = false }
#     if password == password_confirmation and password.to_s.length >= 8
#       break
#     else
#       puts "The password must have 8 or more characters, and this must be equal to its confirmation"
#     end
#   end
#   @user = User.create(:login => 'admin', :email => 'admin@unam.mx', :password => password, :password_confirmation => password_confirmation, :userstatus_id => Userstatus.where(:name => 'Activo').first.id)
#   @user.user_group = UserGroup.new(:group_id => Group.where(:name => 'admin').first.id)
#   @user.save
# end
