ActiveAdmin.register State do
  index do
    column :id
    column :name
    column :country
    column :code
    default_actions
  end

  filter :name
  filter :country
  filter :code
  form do |f|
    f.inputs do
      f.input :name, :as => :string
      f.input :code, :as => :string
      f.input :country
    end
    f.buttons
  end
end
