# encoding: utf-8
ActiveAdmin.register Activity, :as => 'TechnicalActivity' do
  menu :parent => 'Técnico-académicas', :label => 'Actividades técnicas'
  controller do
    def scoped_collection
      Activity.technical
    end
  end

  index :title => 'Actividades técnicas' do
    column :id
    column :name
    column :descr
    column :year
    column :month
    column(:activitytype) { |record| record.activitytype.name }

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name record.user.id,record.year }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end

  filter :user, :label => 'Académico'
  filter :year
  filter :adscription_id, :collection => proc { Adscription.enabled }, :label => 'Adscripción', :as => :select
  filter :name

  csv do
    column :name
    column :descr
    column :year
    column :month
    column(:activitytype) { |record| record.activitytype.name }

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name record.user.id,record.year }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end
end
