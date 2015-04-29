# encoding: utf-8
ActiveAdmin.register UserTechproduct, :as => "TechnicalProduct"  do
  menu :parent => 'Técnico-académicas', :label => 'Productos técnicos'

  index :title => 'Productos técnicos' do
    column(:id) { |record| record.techproduct.id }
    column(:title) { |record| record.techproduct.title }
    column(:authors) { |record| record.techproduct.authors }
    column(:status)  { |record| record.techproduct.techproductstatus.name }
    column(:type)  { |record| record.techproduct.techproducttype.name }
    column(:institution)  { |record| record.techproduct.institution_name }
    column(:country)  { |record| record.techproduct.institution_country }
    column(:year) { |record| record.year}
    column :userrole
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end

  filter :user, :label => 'Académico'
  filter :userrole, :label => 'Rol'
  filter :year, :collection => (Date.today.year - 100 .. Date.today.year + 1).to_a.reverse, :as => :select
  filter :adscription_id, :collection => proc { Adscription.enabled }, :label => 'Adscripción', :as => :select

  csv do
    column(:title) { |record| record.techproduct.title }
    column(:authors) { |record| record.techproduct.authors }
    column(:status)  { |record| record.techproduct.techproductstatus.name }
    column(:type)  { |record| record.techproduct.techproducttype.name }
    column(:institution)  { |record| record.techproduct.institution_name }
    column(:country)  { |record| record.techproduct.institution_country }
    column(:year) { |record| record.year}
    column :userrole
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end
end
