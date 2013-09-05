ActiveAdmin.register Group do
  menu :parent => I18n.t("active_admin.catalogs")

  filter :name
  filter :descr
  filter :created_on
  filter :updated_on
  form do |f|
    f.inputs do
      f.input :name, :as => :string
      f.input :descr, :as => :string
    end
    f.buttons
  end
end
