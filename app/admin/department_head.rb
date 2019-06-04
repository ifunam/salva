# encoding: utf-8
ActiveAdmin.register DepartmentHead do
  menu :parent => 'Catálogos'

  index :title => 'Jefes de departamento' do
    column(:id) { |record| record.id }
    column(:name) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.adscription.name }
    default_actions
  end

  filter :adscription_id_eq, :collection => proc { Adscription.enabled }, :label => 'Departamento', :as => :select

  form do |f|
    f.inputs do
      f.input :user, :collection => User.activated,  :as => :select
      f.input :adscription, :collection => Adscription.enabled,  :as => :select
    end
    f.buttons
  end

  csv do
    column(:id) { |record| record.id }
    column(:name) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.adscription.name }
  end
end
