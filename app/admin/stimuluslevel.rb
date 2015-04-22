# encoding: utf-8
ActiveAdmin.register Stimuluslevel do
  #menu :parent => I18n.t("active_admin.catalogs")
  menu :parent => 'Catálogos'

  index do 
    column :id
    column :stimulustype, :sortable => false
    column :name

    default_actions
  end

  filter :name
  filter :stimulutype

  form do |f|
    f.inputs I18n.t("active_admin.stimuluslevel") do
      f.inputs do
        f.input :name, :as => :string
      end
      f.inputs I18n.t("active_admin.stimulustype"), :for => [:stimulustype, f.object.stimulustype || Stimulustype.new] do |st_form|
        st_form.input :name, :as => :string
        st_form.input :descr, :as => :string
        st_form.input :institution, :as => :select, :collection => Institution.for_schoolarships
      end
      f.buttons
    end
  end
end
