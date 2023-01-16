# RailsAdmin config file. Generated on March 23, 2012 13:32
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|
  config.asset_source = :webpacker

  require 'i18n'
  I18n.default_locale = :es

  config.current_user_method { current_user } # auto-generated
  config.authorize_with :cancancan, Ability

  # If you want to track changes on your models:
  # config.audit_with :history, User

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, User

  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['Salva', 'Admin']

  # or for a dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  #  ==> Global show view settings
  # Display empty fields in show views
  # config.compact_show_view = false

  #  ==> Global list view settings
  # Number of default rows per-page:
  # config.default_items_per_page = 20

  #  ==> Included models
  # Add all excluded models here:
  # config.excluded_models = [Action, Grant, User]

  # Add models here if you want to go 'whitelist mode':
  config.included_models = [Academicprogram, Academicprogramtype, Acadvisittype, Activitygroup, Addresstype, Adscription,
                            Articlestatus, Bookchaptertype, Booktype, Career, Country, Citizenmodality, City, Conferencescope,
                            Conferencetype, Contracttype, Courseduration, Coursegroup, Coursegrouptype, Credential, Credittype,
                            Degree, Documenttype, Editionstatus, Genericworkgroup, Genericworkstatus, Genericworktype,
                            Group, Groupmodality, Identification, Idtype, Indivadviceprogram, Indivadvicetarget, Institution,
                            Institutiontitle, Institutiontype, Jobpositioncategory, Jobpositionlevel, Jobpositiontype, Journal,
                            Language, Languagelevel, Maritalstatus, Mediatype, Migratorystatus, Modality, Newspaper, Period,
                            Prizetype, Projectstatus, Projecttype, Publicationcategory, Publisher, RefereedCriterium,
                            Researcharea, Researchgroup, Researchline, Role, Roleinbook, Roleinchapter, Roleinconference,
                            Roleinconferencetalk, Roleincourse, Roleinjobposition, Roleinjournal, Roleinjury, Roleinproject,
                            Roleinregularcourse, Roleinseminary, Roleinthesis, Roleproceeding, Schoolarship, Seminarytype,
                            Skilltype, State, Stimuluslevel, Stimulustype, Studentrole, Talkacceptance, Talktype, Techproductstatus,
                            Techproducttype, Thesismodality, Thesisstatus, Titlemodality, Userstatus, Volume]

  # Application wide tried label methods for models' instances
  config.label_methods << :description # Default is [:name, :title, :to_s]
  config.label_methods << :to_s

  #  ==> Global models configuration
  # config.models do
  #   # Configuration here will affect all included models in all scopes, handle with care!
  #
  #   list do
  #     # Configuration here will affect all included models in list sections (same for show, export, edit, update, create)
  #
  #     fields_of_type :date do
  #       # Configuration here will affect all date fields, in the list section, for all included models. See README for a comprehensive type list.
  #     end
  #   end
  # end
  #
end
