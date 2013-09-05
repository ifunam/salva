ActiveAdmin.register Adscription do
  filter :name
  filter :abbrev
  filter :administrative_key
  filter :created_on
  filter :updated_on

  form do |f|
    f.inputs do
      f.input :name, :as => :string
      f.input :abbrev, :as => :string
      f.input :descr, :as => :string
      f.input :administrative_key, :as => :string
      f.input :institution_id, :as => :hidden, :value => Institution.where(:administrative_key => Salva::SiteConfig.institution('administrative_key').to_s).first.id
      f.input :is_enabled
    end
    f.buttons
  end
end
