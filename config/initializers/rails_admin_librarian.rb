# encoding: utf-8
# RailsAdmin config file. Generated on March 23, 2012 13:32
# See github.com/sferik/rails_admin for more informations
RailsAdmin.config do |config|

  require 'i18n'
  I18n.default_locale = :es

  config.current_user_method { current_user } # auto-generated
  config.authorize_with :cancancan, Ability

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
  config.included_models = [Article, Journal, ImpactFactor, User, Country, Mediatype, Publisher, UserRefereedJournal, UserJournal,
                            Thesis, UserThesis, Thesismodality, Thesisstatus, Titlemodality, Career, Institution, Degree,
                            Institutiontype, Roleinthesis, Indivadvice, TutorialCommittee, ThesisJuror
                            ]

  # Application wide tried label methods for models' instances
  config.label_methods << :description # Default is [:name, :title, :to_s]
  config.label_methods << :to_s

  config.model ImpactFactor do
    list do 
      field :journal
      field :year
      field :value
    end
    edit do
      field :journal
      field :year
      field :value
    end
  end

  config.model Journal do
    list do
      sort_by :name

      field :name
      field :issn
      field :abbrev
      field :country
      field :is_verified
      field :impact_factor
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
      #field :impact_index
      field :is_verified
      field :has_open_access
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
      field :articlestatus
      field :year
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
        field :users do
            searchable :user_articles => {:users => :author_name}
            #q = bindings[:controller].request.params[:query].to_s
            #User.search(:fullname_like => q)
          #end
        end
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
      field :author_name
      field :email
      field :user_incharge
      field :userstatus
      field :id
    end
  end

  config.model UserRefereedJournal do
    list do 
      field :user
      field :journal
      field :year
      field :month
      field :id
    end
    edit do
      field :user
      field :journal
    end
  end

  config.model Thesismodality do
    list do
      field :name
      field :level
      field :updated_on
    end

    edit do
      field :name, :string
      field :level
    end
  end

  config.model Titlemodality do
    list do
      field :name
    end

    edit do
      field :name, :string
    end
  end

  config.model Roleinthesis do
    list do
      field :name
      field :updated_on
    end

    edit do
      field :name, :string
    end
  end

  config.model Thesisstatus do
    list do
      field :name
      field :updated_on
    end

    edit do
      field :name, :string
    end
  end

  config.model UserThesis do
    list do
      field :thesis
      field :user
      field :roleinthesis
      field :other
    end

    edit do
      field :user
      field :roleinthesis
    end
  end

  config.model ThesisJuror do
    list do
      field :thesis
      field :user
      field :roleinjury
      field :year
      field :month
    end

    edit do
      field :thesis
      field :user
      field :roleinjury
      field :year
      field :month
    end
  end
  config.model Degree do
    list do
      field :name
      field :level
      field :id
    end

    edit do
      field :name, :string
      field :level
      field :careers
      field :thesismodalities
    end
  end
=begin
  config.model Institution do
    edit do
      field :name
      field :abbrev
      field :institutiontitle
      field :institutiontype
      field :country
    end
  end
=end
  config.model Institution do
    list do
      field :name
      field :abbrev
      field :institutiontitle
      field :institutiontype
      field :url
      field :country
      #field :registered_by
      #field :modified_by
    end
    show do
      field :name
      field :abbrev
      field :institutiontitle
      field :institutiontype
      field :url
      field :country
      #field :registered_by
      #field :modified_by
    end
    edit do
      field :name
      field :abbrev
      field :institutiontitle
      field :institutiontype
      field :country
    end
  end

  config.model Career do
    list do
      field :name
      field :abbrev
      field :degree
      field :institution
      field :id
      field :university
      field :country
    end
    show do
      field :name, :string
      field :abbrev, :string
      field :degree
      field :institution
      field :university
      field :country
      field :indivadvices
      field :theses
      field :tutorial_committees
      field :educations
    end
    edit do
      field :name, :string
      field :abbrev, :string
      field :degree
      field :institution
      field :university
      field :country
      # field :indivadvices
      # field :theses
      # field :tutorial_committees
      # field :educations
    end
  end

  config.model Thesis do
    list do
      field :title
      field :authors
      field :start_date
      field :end_date
      field :is_verified
      field :thesisstatus
      field :degree
      field :career
      field :institution
      field :university
      field :id
    end
    edit do
      group :default do 
        field :title
        field :authors
        field :thesisstatus
        field :thesismodality
        field :start_date do
            date_format :default
        end
        field :end_date do
          date_format :default
        end
        field :degree
        field :career
        field :institution
        field :university
        field :other
      end
      group :users do
        label "Asesor(es) del Instituto"
        field :user_theses
      end
#      group :users do
#        label "Asesor(es) del Instituto"
#        field :users do
#            searchable :user_articles => {:users => :author_name}
#            #q = bindings[:controller].request.params[:query].to_s
#            #User.search(:fullname_like => q)
#          #end
#        end
#      end
      group :additional_info do
        label "Información adicional"
        field :document
        field :url, :string
        field :is_verified
        field :other
      end
    end
  end
end
