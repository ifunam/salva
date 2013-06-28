# encoding: utf-8
# RailsAdmin config file. Generated on March 23, 2012 13:32
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|

  require 'i18n'
  I18n.default_locale = :es

  config.current_user_method { current_user } # auto-generated
  config.authorize_with :cancan, Ability

  # If you want to track changes on your models:
  # config.audit_with :history, User

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, User

  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['Salva', 'Librarian']

  # or for a dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  #  ==> Global show view settings
  # Display empty fields in show views
  # config.compact_show_view = false

  #  ==> Global list view settings
  # Number of default rows per-page:
  config.default_items_per_page = 50


  # Add models here if you want to go 'whitelist mode':
  config.included_models = [Article, Journal, User, Country, Mediatype, Publisher]

  # Application wide tried label methods for models' instances
  config.label_methods << :description # Default is [:name, :title, :to_s]
  config.label_methods << :to_s
  config.model Journal do
    list do
      sort_by :name

      field :name
      field :issn
      field :abbrev
      field :country
      field :is_verified
      field :id
      field :users
    end
    edit do
      field :name
      field :issn, :string
      field :url, :string
      field :abbrev, :string
      field :mediatype
      field :publisher
      field :country
      field :impact_index
      field :is_verified
      field :other
      field :articles
    end
  end

  config.model Publisher do
    list do 
      sort_by :name
      field :name
      field :is_verified
      field :id
    end

    edit do
      field :name
      field :descr
      field :url, :string
      field :journals
    end
  end

  config.model Article do
    list do 
      sort_by :year, :month, :title, :authors
      field :title
      field :authors
      field :journal
      field :year
      field :month
      field :is_verified
      field :id
    end

    edit do
      group :default do 
        label "Información del artículo"
        field :title
        field :authors
        field :journal
        field :articlestatus
        field :year
        field :month
        field :vol, :string
        field :num, :string
        field :pages, :string
        field :doi, :string
      end

      group :authors do
        label "Autor(es) del Instituto"
        field :users
      end

      group :additional_info do
        label "Información adicional"
        field :url, :string
        field :document
        field :is_verified
      end

    end
  end

  config.model Mediatype do
    list do
      field :name
      field :id
    end
  end

  config.model Country do
    list do
      field :name
      field :citizen
      field :code
      field :id
    end
  end

  config.model User do
    list do
      field :login
      field :email
      field :user_incharge
      field :userstatus
      field :id
    end
  end
end
