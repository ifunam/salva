# encoding: utf-8
ActiveAdmin.register Activity, :as => 'OtherActivity' do
  menu :parent => 'Otros', :label => 'Otras actividades'
  controller do
    def scoped_collection
      Activity.other
    end
  end

  index :title => 'Otras actividades' do
    column :id
    column :name
    column :descr
    column :year
    column :month
    column(:activitytype) { |record| record.activitytype.name }

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
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
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end
end
