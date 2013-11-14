ActiveAdmin.register City do
  # menu :parent => I18n.t("active_admin.catalogs")
  menu :parent => 'Catálogos'

  index do 
    column :id
    column :name
    column :state
    default_actions
  end

  filter :state
  filter :name

  form do |f|
    f.inputs do
      f.input :name, :as => :string
      f.input :state
    end
    f.buttons
  end
end
