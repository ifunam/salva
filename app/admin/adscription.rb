ActiveAdmin.register Adscription do
  form do |f|
    f.inputs do
      f.input :name, :as => :string
      f.input :abbrev, :as => :string
      f.input :descr, :as => :string
      f.input :administrative_key, :as => :string
      f.input :is_enabled
    end
    f.buttons
  end
end
