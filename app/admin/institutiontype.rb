ActiveAdmin.register Institutiontype do
  menu :parent => I18n.t("active_admin.catalogs")

  form do |f|
    f.inputs do
      f.input :name, :as => :string
    end
    f.buttons
  end
end
