# encoding: utf-8
ActiveAdmin.register MissingPlan do
  menu :parent => 'Catálogos', :label => 'Faltantes PT'

  config.filters = false
  actions :all, except: [:new]

  index :title => 'Planes de trabajo faltantes' do
    column(:id) { |record| record.id }
    column(:email) { |record| record.email }
    column(:fullname) { |record| record.author_name }
  end

  csv do
    column(:email) { |record| record.email }
    column(:fullname) { |record| record.author_name }
  end
end
