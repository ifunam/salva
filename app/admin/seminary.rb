# encoding: utf-8
ActiveAdmin.register UserSeminary, :as => 'Seminary'  do
  menu :parent => 'Congresos', :label => 'Seminarios y conferencias'

  index :title => 'Seminarios y conferencias' do
    column(:id) { |record| record.seminary.id }

    column(:seminary_title) { |record| record.seminary.title }
    column(:seminary_instructors) { |record| record.seminary.instructors }
    column(:seminary_year) { |record| record.seminary.year }
    column(:seminary_month) { |record| record.seminary.month }
    column(:seminary_type) { |record| record.seminary.seminarytype_name }
    column(:seminary_institution) { |record| record.seminary.institution_name }
    column(:seminary_country) { |record| record.seminary.institution_country }

    column(:roleinseminary) { |record| record.roleinseminary.name }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end

  filter :year_eq, :collection => (Date.today.year - 100 .. Date.today.year + 1).to_a.reverse, :label => 'Año', :as => :select
  filter :adscription_id, :collection => proc { Adscription.enabled }, :label => 'Adscripción', :as => :select
  filter :user, :label => 'Académico'
  filter :roleinseminary
  filter :seminary, :label => 'Seminario o Conferencia'

  csv do
    column(:seminary_title) { |record| record.seminary.title }
    column(:seminary_instructors) { |record| record.seminary.instructors }
    column(:seminary_year) { |record| record.seminary.year }
    column(:seminary_month) { |record| record.seminary.month }
    column(:seminary_type) { |record| record.seminary.seminarytype_name }
    column(:seminary_institution) { |record| record.seminary.institution_name }
    column(:seminary_country) { |record| record.seminary.institution_country }

    column(:roleinseminary) { |record| record.roleinseminary.name }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end
end
