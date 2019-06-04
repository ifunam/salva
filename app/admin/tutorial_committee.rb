# encoding: utf-8
ActiveAdmin.register TutorialCommittee do
  menu :parent => 'Docencia', :label => 'Comités tutorales'

  index :title => 'Comités tutorales' do
    column :id
    column :studentname
    column :descr
    column :year
    column(:degree) { |record| record.degree.nil? ? nil : record.degree.name }
    column(:career) { |record| record.career.nil? ? nil : record.career.name }
    column(:faculty) { |record| record.institution.nil? ? nil : record.institution.name }
    column(:university) { |record| record.university.nil? ? nil : record.university.name }
    column(:country) { |record| record.country.nil? ? nil : record.country.name }

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name record.user.id,record.year }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end

  filter :degree_id, :collection => proc { Degree.universitary }, :label => 'Grado', :as => :select
  filter :user, :label => 'Académico'
  filter :year
  filter :adscription_id, :collection => proc { Adscription.enabled }, :label => 'Adscripción', :as => :select
  filter :studentname

  csv do
    column :studentname
    column :descr
    column :year
    column(:degree) { |record| record.degree.nil? ? nil : record.degree.name }
    column(:career) { |record| record.career.nil? ? nil : record.career.name }
    column(:faculty) { |record| record.institution.nil? ? nil : record.institution.name }
    column(:university) { |record| record.university.nil? ? nil : record.university.name }
    column(:country) { |record| record.country.nil? ? nil : record.country.name }

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name record.user.id,record.year }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end
end
