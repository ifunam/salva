# encoding: utf-8
ActiveAdmin.register TutorialCommittee do
  menu :parent => 'Docencia', :label => 'Comités tutorales'

  index :title => 'Comités tutorales' do
    column :id
    column :studentname
    column :descr
    column :year
    column(:career) { |record| record.career.name }
    column(:degree) { |record| record.career.degree.name }
    column(:faculty) { |record| record.career.institution.name}
    column(:institution) { |record| record.career.institution.parent_name}
    column(:country) { |record| record.career.institution.country_name}

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
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
    column(:career) { |record| record.career.name }
    column(:degree) { |record| record.career.degree.name }
    column(:faculty) { |record| record.career.institution.name}
    column(:institution) { |record| record.career.institution.parent_name}
    column(:country) { |record| record.career.institution.country_name}

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end
end
