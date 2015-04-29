# encoding: utf-8
ActiveAdmin.register Instadvice, :as => 'InstitutionalAdvice' do
  menu :parent => 'Vinculación', :label => 'Asesoría a instituciones'

  index :title => 'Asesoría a instituciones' do
    column :id

    column :title
    column :year
    column :month
    column(:institution) { |record| record.institution.name }

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end

  filter :user, :label => 'Académico'
  filter :year
  filter :adscription_id, :collection => proc { Adscription.enabled }, :label => 'Adscripción', :as => :select

  csv do
    column :title
    column :year
    column :month
    column(:institution) { |record| record.institution.name }

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end
end
