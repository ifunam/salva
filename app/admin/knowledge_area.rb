# encoding: utf-8
ActiveAdmin.register KnowledgeArea do
  # menu :parent => I18n.t("active_admin.catalogs")
  menu :parent => 'Catálogos'
  filter :name

  form do |f|
    f.inputs do
      f.input :name, :as => :string
      f.input :name_en, :as => :string
      f.input :short_name, :as => :string
      f.input :knowledge_field, :collection => KnowledgeField.all,  :as => :select
    end
    f.buttons
  end
end
