# encoding: utf-8
ActiveAdmin.register Maritalstatus do
  # menu :parent => I18n.t("active_admin.catalogs")
  menu :parent => 'Catálogos'

  form do |f|
    f.inputs do
      f.input :name, :as => :string
    end
    f.buttons
  end
end
