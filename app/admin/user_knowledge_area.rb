# encoding: utf-8
ActiveAdmin.register UserKnowledgeArea do
  menu :parent => 'Catálogos'
  filter :user
  filter :knowledge_area

  index :title => 'Áreas del conocimiento' do
    column(:user) { |record| record.user.fullname_or_email }
    column(:category) { |record| record.user.category_name }
    column(:userstatus) { |record| record.user.userstatus.name }
    column(:knowledge_area) { |record| record.knowledge_area.id }
    column(:knowledge_area) { |record| record.knowledge_area.name }
    column(:knowledge_flied) { |record| record.knowledge_area.knowledge_field.id }
    column(:knowledge_flied) { |record| record.knowledge_area.knowledge_field.name }
  end

  csv do
    column(:user) { |record| record.user.fullname_or_email }
    column(:category) { |record| record.user.category_name }
    column(:userstatus) { |record| record.user.userstatus.name }
    column(:knowledge_area) { |record| record.knowledge_area.name }
    column(:knowledge_flied) { |record| record.knowledge_area.knowledge_field.name }
  end

end
