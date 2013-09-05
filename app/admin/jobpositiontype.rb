ActiveAdmin.register Jobpositiontype do
  form do |f|
    f.inputs do
      f.input :name, :as => :string
    end
    f.buttons
  end
end
