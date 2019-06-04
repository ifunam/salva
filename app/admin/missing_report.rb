# encoding: utf-8
ActiveAdmin.register MissingReport do
  menu :parent => 'Catálogos', :label => 'Faltantes IA'
  config.filters = false
  actions :all, except: [:new]

  index :title => 'Informes anuales faltantes' do
    column(:id) { |record| record.id }
    column(:email) { |record| record.email }
    column(:fullname) { |record| record.author_name }
  end

  csv do
    column(:email) { |record| record.email }
    column(:fullname) { |record| record.author_name }
  end
end
