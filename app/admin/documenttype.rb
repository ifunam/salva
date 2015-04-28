# encoding: utf-8
ActiveAdmin.register Documenttype do
  menu :priority => 2

  form do |f|
    f.inputs do
      f.input :name, :as => :string
      f.input :year, :as => :string
      f.input :start_date, :as => :string, :input_html => {:class => 'start-date'}
      f.input :end_date, :as => :string, :input_html => {:class => 'end-date'}
      f.input :descr, :as => :string
      f.input :status
    end
    f.buttons
  end
end
