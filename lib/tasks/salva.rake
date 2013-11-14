Rake.application.instance_variable_get('@tasks').delete('default')
namespace :salva do
  desc "To create the admin user account in the salva database"
  task :create_admin => :environment do
    password = (0...8).map{(65+rand(26)).chr}.join
    @admin = User.create!(:login => 'admin', :email => 'admin@unam.mx', :password => password, :password => password, :userstatus_id => 2)
    @admin.build_user_group.group = Group.find_by_name('admin')
    if @admin.save
      puts "The admin account has been created, to enter to the system open this url http://localhost:3000/admin/"
      puts "login: admin"
      puts "password: #{password}"
    else
      puts @admin.errors.full_messages
    end
  end

  desc "To delete admin user account in the salva database"
  task :drop_admin => :environment do
    @admin = User.where(:login => 'admin').first
    unless @admin.nil?
      @admin.destroy
      puts "The admin user account has been dropped"
    else
      puts "The admin user account does not exist"
    end
  end
end


