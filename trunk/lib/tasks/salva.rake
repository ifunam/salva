namespace :salva do

  desc "Run Unit tests for salva"
  task :test_units do
    sh "rake db:schema:load RAILS_ENV=test"
    sh "rake db:fixtures:load"
  end

end
