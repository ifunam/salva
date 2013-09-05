ActiveAdmin.register Schoolarship do

  index do 
    column :id
    column :name_and_institution_abbrev
    column :created_on
    column :updated_on
    default_actions
  end

  filter :name
  filter :institution, :as => :select, :collection => Institution.for_schoolarships

  form do |f|
    f.inputs do
      f.input :name, :as => :string
      f.input :institution, :as => :select, :collection => Institution.for_schoolarships
    end
    f.buttons
  end
end
