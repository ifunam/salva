ActiveAdmin.register Group do
  form do |f|
    f.inputs do
      f.input :name, :as => :string
      f.input :descr, :as => :string
    end
    f.buttons
  end
end
