# encoding: utf-8
ActiveAdmin.register Period do
  # menu :parent => I18n.t("active_admin.catalogs")
  menu :parent => 'Catálogos'

  filter :title
  filter :startdate
  filter :enddate
  form do |f|
    f.inputs do
      f.input :title, :as => :string
      f.input :startdate, :as => :string
      f.input :enddate, :as => :string
    end
    f.buttons
  end
end
