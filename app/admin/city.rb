ActiveAdmin.register City do
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
