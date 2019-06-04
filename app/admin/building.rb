# encoding: utf-8
ActiveAdmin.register Building do
  menu :parent => 'Catálogos'

  index :title => 'Edificios' do
    column(:id) { |record| record.id }
    column(:name) { |record| record.name }
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :id, :as => :hidden, :value => f.object.id || Building.last.id+1
      f.input :name, :as => :string
    end
    f.buttons
  end

  csv do
    column(:id) { |record| record.id }
    column(:name) { |record| record.name }
  end
end
