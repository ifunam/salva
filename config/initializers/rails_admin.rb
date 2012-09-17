# RailsAdmin config file. Generated on March 23, 2012 13:32
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|

  # If your default_local is different from :en, uncomment the following 2 lines and set your default locale here:
  require 'i18n'
  I18n.default_locale = :es

  config.current_user_method { current_user } # auto-generated
  config.authorize_with :cancan, Ability

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
  config.included_models = [Institution, Institutiontype, Institutiontitle]

  # Application wide tried label methods for models' instances
  config.label_methods << :description # Default is [:name, :title, :as_text]
  config.label_methods << :as_text

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
  #  ==> Model specific configuration
  # Keep in mind that *all* configuration blocks are optional.
  # RailsAdmin will try his best to provide the best defaults for each section, for each field.
  # Try to override as few things as possible, in the most generic way. Try to avoid setting labels for models and attributes, use ActiveRecord I18n API instead.
  # Less code is better code!
  # config.model MyModel do
  #   # Cross-section field configuration
  #   object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #   label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #   label_plural 'My models'      # Same, plural
  #   weight -1                     # Navigation priority. Bigger is higher.
  #   parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #   navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  #   # Section specific configuration:
  #   list do
  #     filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #     items_per_page 100    # Override default_items_per_page
  #     sort_by :id           # Sort column (default is primary key)
  #     sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     # Here goes the fields configuration for the list view
  #   end
  # end

  # Your model's configuration, to help you get started:

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible. (visible(true))

  # config.model Academic do
  #   # Found associations:
  #     configure :userstatus, :belongs_to_association 
  #     configure :user_incharge, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :person, :has_one_association 
  #     configure :user_group, :has_one_association 
  #     configure :address, :has_one_association 
  #     configure :professional_address, :has_one_association 
  #     configure :jobposition, :has_one_association 
  #     configure :most_recent_jobposition, :has_one_association 
  #     configure :jobposition_for_researching, :has_one_association 
  #     configure :user_identification, :has_one_association 
  #     configure :user_schoolarship, :has_one_association 
  #     configure :user_cite, :has_one_association 
  #     configure :jobposition_log, :has_one_association 
  #     configure :session_preference, :has_one_association 
  #     configure :user_adscriptions, :has_many_association 
  #     configure :jobpositions, :has_many_association 
  #     configure :user_adscription, :has_one_association 
  #     configure :jobposition_as_postdoctoral, :has_one_association 
  #     configure :user_adscription_as_postdoctoral, :has_one_association 
  #     configure :user_schoolarships, :has_many_association 
  #     configure :user_schoolarships_as_posdoctoral, :has_many_association 
  #     configure :documents, :has_many_association 
  #     configure :user_identifications, :has_many_association 
  #     configure :user_researchlines, :has_many_association 
  #     configure :researchlines, :has_many_association 
  #     configure :user_skills, :has_many_association 
  #     configure :user_articles, :has_many_association 
  #     configure :articles, :has_many_association 
  #     configure :published_articles, :has_many_association 
  #     configure :recent_published_articles, :has_many_association 
  #     configure :inprogress_articles, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :login, :text 
  #     configure :password, :password         # Hidden 
  #     configure :password_confirmation, :password         # Hidden 
  #     configure :password_salt, :text         # Hidden 
  #     configure :reset_password_token, :string         # Hidden 
  #     configure :remember_token, :string         # Hidden 
  #     configure :userstatus_id, :integer         # Hidden 
  #     configure :email, :text 
  #     configure :homepage, :text 
  #     configure :blog, :text 
  #     configure :calendar, :text 
  #     configure :pkcs7, :text 
  #     configure :token, :text 
  #     configure :token_expiry, :datetime 
  #     configure :user_incharge_id, :integer         # Hidden 
  #     configure :modified_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :author_name, :text 
  #     configure :current_sign_in_ip, :string 
  #     configure :last_sign_in_ip, :string 
  #     configure :remember_created_at, :datetime 
  #     configure :current_sign_in_at, :datetime 
  #     configure :last_sign_in_at, :datetime 
  #     configure :sign_in_count, :integer 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :homepage_resume, :text 
  #     configure :homepage_resume_en, :text 
  #     configure :failed_attempts, :integer 
  #     configure :locked_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Academicprogram do
  #   # Found associations:
  #     configure :institutioncareer, :belongs_to_association 
  #     configure :academicprogramtype, :belongs_to_association 
  #     configure :career, :belongs_to_association 
  #     configure :regularcourses, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :institutioncareer_id, :integer         # Hidden 
  #     configure :academicprogramtype_id, :integer         # Hidden 
  #     configure :year, :integer 
  #     configure :moduser_id, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :career_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Academicprogramtype do
  #   # Found associations:
  #     configure :academicprograms, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Acadvisit do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :institution, :belongs_to_association 
  #     configure :country, :belongs_to_association 
  #     configure :acadvisittype, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :projectacadvisits, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :institution_id, :integer         # Hidden 
  #     configure :country_id, :integer         # Hidden 
  #     configure :acadvisittype_id, :integer         # Hidden 
  #     configure :descr, :text 
  #     configure :startyear, :integer 
  #     configure :startmonth, :integer 
  #     configure :endyear, :integer 
  #     configure :endmonth, :integer 
  #     configure :place, :text 
  #     configure :goals, :text 
  #     configure :other, :text 
  #     configure :externaluser_id, :integer 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Acadvisittype do
  #   # Found associations:
  #     configure :acadvisits, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Action do
  #   # Found associations:
  #     configure :permissions, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Activity do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :activitytype, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :activitytype_id, :integer         # Hidden 
  #     configure :name, :text 
  #     configure :descr, :text 
  #     configure :year, :integer 
  #     configure :month, :integer 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Activitygroup do
  #   # Found associations:
  #     configure :activitytypes, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Activitytype do
  #   # Found associations:
  #     configure :activitygroup, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :activities, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :activitygroup_id, :integer         # Hidden 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Address do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :addresstype, :belongs_to_association 
  #     configure :country, :belongs_to_association 
  #     configure :state, :belongs_to_association 
  #     configure :city, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :addresstype_id, :integer         # Hidden 
  #     configure :location, :text 
  #     configure :pobox, :text 
  #     configure :country_id, :integer         # Hidden 
  #     configure :state_id, :integer         # Hidden 
  #     configure :city_id, :integer         # Hidden 
  #     configure :zipcode, :integer 
  #     configure :phone, :text 
  #     configure :fax, :text 
  #     configure :movil, :text 
  #     configure :other, :text 
  #     configure :is_postaddress, :boolean 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Addresstype do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Adscription do
  #   # Found associations:
  #     configure :institution, :belongs_to_association 
  #     configure :user_adscriptions, :has_many_association 
  #     configure :users, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :abbrev, :text 
  #     configure :descr, :text 
  #     configure :institution_id, :integer         # Hidden 
  #     configure :administrative_key, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :is_enabled, :boolean   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model AnnualPlan do
  #   # Found associations:
  #     configure :documenttype, :belongs_to_association 
  #     configure :user, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :documenttype_id, :integer         # Hidden 
  #     configure :body, :text 
  #     configure :user_id, :integer         # Hidden 
  #     configure :delivered, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Article do
  #   # Found associations:
  #     configure :journal, :belongs_to_association 
  #     configure :articlestatus, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :user_articles, :has_many_association 
  #     configure :users, :has_many_association 
  #     configure :versions, :has_many_association         # Hidden   #   # Found columns:
  #     configure :id, :integer 
  #     configure :title, :text 
  #     configure :journal_id, :integer         # Hidden 
  #     configure :articlestatus_id, :integer         # Hidden 
  #     configure :pages, :text 
  #     configure :year, :integer 
  #     configure :month, :integer 
  #     configure :vol, :text 
  #     configure :num, :text 
  #     configure :authors, :text 
  #     configure :url, :text 
  #     configure :pacsnum, :text 
  #     configure :other, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :doi, :text 
  #     configure :is_verified, :boolean 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Articlestatus do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Book do
  #   # Found associations:
  #     configure :country, :belongs_to_association 
  #     configure :booktype, :belongs_to_association 
  #     configure :language, :belongs_to_association 
  #     configure :bookeditions, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :title, :text 
  #     configure :authors, :text 
  #     configure :booklink, :text 
  #     configure :country_id, :integer         # Hidden 
  #     configure :booktype_id, :integer         # Hidden 
  #     configure :volume, :text 
  #     configure :language_id, :integer         # Hidden 
  #     configure :registered_by_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Bookchaptertype do
  #   # Found associations:
  #     configure :chapterinbooks, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Bookedition do
  #   # Found associations:
  #     configure :book, :belongs_to_association 
  #     configure :mediatype, :belongs_to_association 
  #     configure :editionstatus, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :bookedition_publishers, :has_many_association 
  #     configure :publishers, :has_many_association 
  #     configure :bookedition_roleinbooks, :has_many_association 
  #     configure :users, :has_many_association 
  #     configure :versions, :has_many_association         # Hidden   #   # Found columns:
  #     configure :id, :integer 
  #     configure :book_id, :integer         # Hidden 
  #     configure :edition, :text 
  #     configure :isbn, :text 
  #     configure :mediatype_id, :integer         # Hidden 
  #     configure :editionstatus_id, :integer         # Hidden 
  #     configure :month, :integer 
  #     configure :year, :integer 
  #     configure :other, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :pages, :text 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model BookeditionComment do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :bookedition, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :bookedition_id, :integer         # Hidden 
  #     configure :comment, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model BookeditionPublisher do
  #   # Found associations:
  #     configure :bookedition, :belongs_to_association 
  #     configure :publisher, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :bookedition_id, :integer         # Hidden 
  #     configure :publisher_id, :integer         # Hidden 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model BookeditionRoleinbook do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :bookedition, :belongs_to_association 
  #     configure :roleinbook, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :bookedition_id, :integer         # Hidden 
  #     configure :roleinbook_id, :integer         # Hidden 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Booktype do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Career do
  #   # Found associations:
  #     configure :degree, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :institution, :belongs_to_association 
  #     configure :indivadvices, :has_many_association 
  #     configure :educations, :has_many_association 
  #     configure :tutorial_committees, :has_many_association 
  #     configure :theses, :has_many_association 
  #     configure :academicprograms, :has_many_association 
  #     configure :institutioncareers, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :abbrev, :text 
  #     configure :degree_id, :integer         # Hidden 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden 
  #     configure :institution_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Chapterinbook do
  #   # Found associations:
  #     configure :bookedition, :belongs_to_association 
  #     configure :bookchaptertype, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :chapterinbook_roleinchapters, :has_many_association 
  #     configure :users, :has_many_association 
  #     configure :versions, :has_many_association         # Hidden   #   # Found columns:
  #     configure :id, :integer 
  #     configure :bookedition_id, :integer         # Hidden 
  #     configure :bookchaptertype_id, :integer         # Hidden 
  #     configure :title, :text 
  #     configure :pages, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model ChapterinbookComment do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :chapterinbook, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :chapterinbook_id, :integer         # Hidden 
  #     configure :comment, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model ChapterinbookRoleinchapter do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :chapterinbook, :belongs_to_association 
  #     configure :roleinchapter, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :bookeditions, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :chapterinbook_id, :integer         # Hidden 
  #     configure :roleinchapter_id, :integer         # Hidden 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Citizen do
  #   # Found associations:
  #     configure :citizen_country, :belongs_to_association 
  #     configure :migratorystatus, :belongs_to_association 
  #     configure :citizenmodality, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :citizen_country_id, :integer         # Hidden 
  #     configure :migratorystatus_id, :integer         # Hidden 
  #     configure :citizenmodality_id, :integer         # Hidden 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Citizenmodality do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model City do
  #   # Found associations:
  #     configure :state, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :people, :has_many_association 
  #     configure :addresses, :has_many_association 
  #     configure :institutions, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :state_id, :integer         # Hidden 
  #     configure :name, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Conference do
  #   # Found associations:
  #     configure :conferencetype, :belongs_to_association 
  #     configure :country, :belongs_to_association 
  #     configure :conferencescope, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :conference_institutions, :has_many_association 
  #     configure :institutions, :has_many_association 
  #     configure :userconferences, :has_many_association 
  #     configure :users, :has_many_association 
  #     configure :proceedings, :has_many_association 
  #     configure :versions, :has_many_association         # Hidden   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :url, :text 
  #     configure :month, :integer 
  #     configure :year, :integer 
  #     configure :conferencetype_id, :integer         # Hidden 
  #     configure :country_id, :integer         # Hidden 
  #     configure :conferencescope_id, :integer         # Hidden 
  #     configure :location, :text 
  #     configure :isspecialized, :boolean 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :other, :text 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model ConferenceInstitution do
  #   # Found associations:
  #     configure :conference, :belongs_to_association 
  #     configure :institution, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :conference_id, :integer         # Hidden 
  #     configure :institution_id, :integer         # Hidden 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Conferencescope do
  #   # Found associations:
  #     configure :conferences, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Conferencetalk do
  #   # Found associations:
  #     configure :conference, :belongs_to_association 
  #     configure :talktype, :belongs_to_association 
  #     configure :talkacceptance, :belongs_to_association 
  #     configure :modality, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :user_conferencetalks, :has_many_association 
  #     configure :users, :has_many_association 
  #     configure :versions, :has_many_association         # Hidden   #   # Found columns:
  #     configure :id, :integer 
  #     configure :title, :text 
  #     configure :authors, :text 
  #     configure :abstract, :text 
  #     configure :conference_id, :integer         # Hidden 
  #     configure :talktype_id, :integer         # Hidden 
  #     configure :talkacceptance_id, :integer         # Hidden 
  #     configure :modality_id, :integer         # Hidden 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Conferencetype do
  #   # Found associations:
  #     configure :conferences, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Contracttype do
  #   # Found associations:
  #     configure :jobpositions, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Controller do
  #   # Found associations:
  #     configure :permissions, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Country do
  #   # Found associations:
  #     configure :states, :has_many_association 
  #     configure :journals, :has_many_association 
  #     configure :newspapers, :has_many_association 
  #     configure :acadvisits, :has_many_association 
  #     configure :courses, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :citizen, :text 
  #     configure :code, :string   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Course do
  #   # Found associations:
  #     configure :country, :belongs_to_association 
  #     configure :institution, :belongs_to_association 
  #     configure :courseduration, :belongs_to_association 
  #     configure :modality, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :user_courses, :has_many_association 
  #     configure :users, :has_many_association 
  #     configure :versions, :has_many_association         # Hidden   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :country_id, :integer         # Hidden 
  #     configure :institution_id, :integer         # Hidden 
  #     configure :coursegroup_id, :integer 
  #     configure :courseduration_id, :integer         # Hidden 
  #     configure :modality_id, :integer         # Hidden 
  #     configure :startyear, :integer 
  #     configure :startmonth, :integer 
  #     configure :endyear, :integer 
  #     configure :endmonth, :integer 
  #     configure :hoursxweek, :integer 
  #     configure :location, :text 
  #     configure :totalhours, :integer 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Courseduration do
  #   # Found associations:
  #     configure :courses, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :days, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Coursegroup do
  #   # Found associations:
  #     configure :coursegrouptype, :belongs_to_association 
  #     configure :courses, :has_many_association 
  #     configure :user_courses, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :coursegrouptype_id, :integer         # Hidden 
  #     configure :startyear, :integer 
  #     configure :startmonth, :integer 
  #     configure :endyear, :integer 
  #     configure :endmonth, :integer 
  #     configure :totalhours, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Coursegrouptype do
  #   # Found associations:
  #     configure :coursegroups, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Credential do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :abbrev, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Credittype do
  #   # Found associations:
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :user_credits, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Degree do
  #   # Found associations:
  #     configure :careers, :has_many_association 
  #     configure :indivadvices, :has_many_association 
  #     configure :tutorial_committees, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Document do
  #   # Found associations:
  #     configure :documenttype, :belongs_to_association 
  #     configure :user, :belongs_to_association 
  #     configure :approved_by, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :documenttype_id, :integer         # Hidden 
  #     configure :title, :text 
  #     configure :startdate, :date 
  #     configure :enddate, :date 
  #     configure :registered_by_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :user_id, :integer         # Hidden 
  #     configure :document_type_id, :integer 
  #     configure :file, :string 
  #     configure :modified_by_id, :integer 
  #     configure :approved_by_id, :integer         # Hidden 
  #     configure :approved, :boolean 
  #     configure :signature, :text 
  #     configure :ip_address, :string 
  #     configure :comments, :text 
  #     configure :is_hidden, :boolean   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model DocumentType do
  #   # Found associations:
  #     configure :documents, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Documenttype do
  #   # Found associations:
  #     configure :documents, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :descr, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :start_date, :date 
  #     configure :end_date, :date 
  #     configure :year, :integer 
  #     configure :status, :boolean   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Editionstatus do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Education do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :institutioncareer, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :career, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :institutioncareer_id, :integer         # Hidden 
  #     configure :startyear, :integer 
  #     configure :endyear, :integer 
  #     configure :studentid, :text 
  #     configure :credits, :integer 
  #     configure :average, :float 
  #     configure :is_studying_this, :boolean 
  #     configure :is_titleholder, :boolean 
  #     configure :other, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden 
  #     configure :career_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Genericwork do
  #   # Found associations:
  #     configure :genericworktype, :belongs_to_association 
  #     configure :genericworkstatus, :belongs_to_association 
  #     configure :institution, :belongs_to_association 
  #     configure :publisher, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :user_genericworks, :has_many_association 
  #     configure :users, :has_many_association 
  #     configure :versions, :has_many_association         # Hidden   #   # Found columns:
  #     configure :id, :integer 
  #     configure :title, :text 
  #     configure :authors, :text 
  #     configure :genericworktype_id, :integer         # Hidden 
  #     configure :genericworkstatus_id, :integer         # Hidden 
  #     configure :institution_id, :integer         # Hidden 
  #     configure :publisher_id, :integer         # Hidden 
  #     configure :reference, :text 
  #     configure :vol, :text 
  #     configure :pages, :text 
  #     configure :year, :integer 
  #     configure :month, :integer 
  #     configure :isbn_issn, :text 
  #     configure :other, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Genericworkgroup do
  #   # Found associations:
  #     configure :genericworktypes, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Genericworkstatus do
  #   # Found associations:
  #     configure :genericworks, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Genericworktype do
  #   # Found associations:
  #     configure :genericworkgroup, :belongs_to_association 
  #     configure :genericworks, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :abbrev, :text 
  #     configure :genericworkgroup_id, :integer         # Hidden 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Grant do
  #   # Found associations:
  #     configure :institution, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :institution_id, :integer         # Hidden 
  #     configure :moduser_id, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Group do
  #   # Found associations:
  #     configure :group, :belongs_to_association 
  #     configure :user_groups, :has_many_association 
  #     configure :roleingroups, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :descr, :text 
  #     configure :parent_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Groupmodality do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Identification do
  #   # Found associations:
  #     configure :idtype, :belongs_to_association 
  #     configure :citizen_country, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :idtype_id, :integer         # Hidden 
  #     configure :citizen_country_id, :integer         # Hidden 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Idtype do
  #   # Found associations:
  #     configure :user_identifications, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Image do
  #   # Found associations:
  #     configure :imageable, :polymorphic_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :file, :carrierwave 
  #     configure :imageable_id, :integer         # Hidden 
  #     configure :imageable_type, :string         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Indivadvice do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :indivuser, :belongs_to_association 
  #     configure :institution, :belongs_to_association 
  #     configure :indivadvicetarget, :belongs_to_association 
  #     configure :indivadviceprogram, :belongs_to_association 
  #     configure :degree, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :career, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :indivname, :text 
  #     configure :indivuser_id, :integer         # Hidden 
  #     configure :institution_id, :integer         # Hidden 
  #     configure :indivadvicetarget_id, :integer         # Hidden 
  #     configure :indivadviceprogram_id, :integer         # Hidden 
  #     configure :degree_id, :integer         # Hidden 
  #     configure :startyear, :integer 
  #     configure :startmonth, :integer 
  #     configure :endyear, :integer 
  #     configure :endmonth, :integer 
  #     configure :hours, :integer 
  #     configure :other, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden 
  #     configure :career_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Indivadviceprogram do
  #   # Found associations:
  #     configure :institution, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :descr, :text 
  #     configure :institution_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Indivadvicetarget do
  #   # Found associations:
  #     configure :instadvices, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Inproceeding do
  #   # Found associations:
  #     configure :proceeding, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :user_inproceedings, :has_many_association 
  #     configure :users, :has_many_association 
  #     configure :versions, :has_many_association         # Hidden   #   # Found columns:
  #     configure :id, :integer 
  #     configure :proceeding_id, :integer         # Hidden 
  #     configure :title, :text 
  #     configure :authors, :text 
  #     configure :pages, :text 
  #     configure :comment, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Instadvice do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :institution, :belongs_to_association 
  #     configure :instadvicetarget, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :title, :text 
  #     configure :user_id, :integer         # Hidden 
  #     configure :institution_id, :integer         # Hidden 
  #     configure :instadvicetarget_id, :integer         # Hidden 
  #     configure :other, :text 
  #     configure :year, :integer 
  #     configure :month, :integer 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Instadvicetarget do
  #   # Found associations:
  #     configure :instadvices, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Institution do
  #   # Found associations:
  #     configure :institutiontype, :belongs_to_association 
  #     configure :institution, :belongs_to_association 
  #     configure :institutiontitle, :belongs_to_association 
  #     configure :country, :belongs_to_association 
  #     configure :state, :belongs_to_association 
  #     configure :city, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :acadvisits, :has_many_association 
  #     configure :adscriptions, :has_many_association 
  #     configure :careers, :has_many_association 
  #     configure :conference_institutions, :has_many_association 
  #     configure :courses, :has_many_association 
  #     configure :genericworks, :has_many_association 
  #     configure :grants, :has_many_association 
  #     configure :indivadvices, :has_many_association 
  #     configure :indivadviceprograms, :has_many_association 
  #     configure :instadvices, :has_many_association 
  #     configure :institutions, :has_many_association 
  #     configure :institutional_activities, :has_many_association 
  #     configure :institutioncareers, :has_many_association 
  #     configure :jobpositions, :has_many_association 
  #     configure :memberships, :has_many_association 
  #     configure :prizes, :has_many_association 
  #     configure :projectfinancingsources, :has_many_association 
  #     configure :projectinstitutions, :has_many_association 
  #     configure :schoolarships, :has_many_association 
  #     configure :seminaries, :has_many_association 
  #     configure :sponsor_acadvisits, :has_many_association 
  #     configure :stimulustypes, :has_many_association 
  #     configure :techproducts, :has_many_association 
  #     configure :user_languages, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :institutiontype_id, :integer         # Hidden 
  #     configure :name, :text 
  #     configure :url, :text 
  #     configure :abbrev, :text 
  #     configure :institution_id, :integer         # Hidden 
  #     configure :institutiontitle_id, :integer         # Hidden 
  #     configure :addr, :text 
  #     configure :country_id, :integer         # Hidden 
  #     configure :state_id, :integer         # Hidden 
  #     configure :city_id, :integer         # Hidden 
  #     configure :zipcode, :text 
  #     configure :phone, :text 
  #     configure :fax, :text 
  #     configure :administrative_key, :text 
  #     configure :other, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model InstitutionalActivity do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :institution, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :descr, :text 
  #     configure :institution_id, :integer         # Hidden 
  #     configure :startmonth, :integer 
  #     configure :startyear, :integer 
  #     configure :endmonth, :integer 
  #     configure :endyear, :integer 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Institutioncareer do
  #   # Found associations:
  #     configure :institution, :belongs_to_association 
  #     configure :career, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :institution_id, :integer         # Hidden 
  #     configure :career_id, :integer         # Hidden 
  #     configure :url, :text 
  #     configure :other, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Institutiontitle do
  #   # Found associations:
  #     configure :institutions, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Institutiontype do
  #   # Found associations:
  #     configure :institutions, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Jobposition do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :jobpositioncategory, :belongs_to_association 
  #     configure :contracttype, :belongs_to_association 
  #     configure :institution, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :user_adscriptions, :has_many_association 
  #     configure :user_adscription, :has_one_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :jobpositioncategory_id, :integer         # Hidden 
  #     configure :contracttype_id, :integer         # Hidden 
  #     configure :institution_id, :integer         # Hidden 
  #     configure :descr, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :start_date, :date 
  #     configure :end_date, :date 
  #     configure :place_of_origin, :text 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model JobpositionLog do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :worker_key, :text 
  #     configure :academic_years, :integer 
  #     configure :administrative_years, :integer 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :worker_number, :string 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Jobpositioncategory do
  #   # Found associations:
  #     configure :jobpositiontype, :belongs_to_association 
  #     configure :roleinjobposition, :belongs_to_association 
  #     configure :jobpositionlevel, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :jobpositiontype_id, :integer         # Hidden 
  #     configure :roleinjobposition_id, :integer         # Hidden 
  #     configure :jobpositionlevel_id, :integer         # Hidden 
  #     configure :administrative_key, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Jobpositionlevel do
  #   # Found associations:
  #     configure :jobpositioncategories, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Jobpositiontype do
  #   # Found associations:
  #     configure :jobpositioncategories, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Journal do
  #   # Found associations:
  #     configure :mediatype, :belongs_to_association 
  #     configure :publisher, :belongs_to_association 
  #     configure :country, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :user_journals, :has_many_association 
  #     configure :articles, :has_many_association 
  #     configure :user_refereed_journals, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :issn, :text 
  #     configure :url, :text 
  #     configure :abbrev, :text 
  #     configure :other, :text 
  #     configure :mediatype_id, :integer         # Hidden 
  #     configure :publisher_id, :integer         # Hidden 
  #     configure :country_id, :integer         # Hidden 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :impact_index, :float 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Language do
  #   # Found associations:
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :user_languages, :has_many_association 
  #     configure :books, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Languagelevel do
  #   # Found associations:
  #     configure :user_languages, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Maritalstatus do
  #   # Found associations:
  #     configure :people, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Mediatype do
  #   # Found associations:
  #     configure :journals, :has_many_association 
  #     configure :bookeditions, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Membership do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :institution, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :institution_id, :integer         # Hidden 
  #     configure :descr, :text 
  #     configure :startyear, :integer 
  #     configure :endyear, :integer 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Migratorystatus do
  #   # Found associations:
  #     configure :citizens, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Modality do
  #   # Found associations:
  #     configure :courses, :has_many_association 
  #     configure :conferencetalks, :has_many_association 
  #     configure :regularcourses, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Newspaper do
  #   # Found associations:
  #     configure :country, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :newspaperarticles, :has_many_association 
  #     configure :user_newspaperarticles, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :url, :text 
  #     configure :country_id, :integer         # Hidden 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Newspaperarticle do
  #   # Found associations:
  #     configure :newspaper, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :user_newspaperarticles, :has_many_association 
  #     configure :users, :has_many_association 
  #     configure :versions, :has_many_association         # Hidden   #   # Found columns:
  #     configure :id, :integer 
  #     configure :title, :text 
  #     configure :authors, :text 
  #     configure :newspaper_id, :integer         # Hidden 
  #     configure :newsdate, :date 
  #     configure :pages, :text 
  #     configure :url, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Period do
  #   # Found associations:
  #     configure :user_regularcourses, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :title, :text 
  #     configure :startdate, :date 
  #     configure :enddate, :date 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Permission do
  #   # Found associations:
  #     configure :roleingroup, :belongs_to_association 
  #     configure :controller, :belongs_to_association 
  #     configure :action, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :roleingroup_id, :integer         # Hidden 
  #     configure :controller_id, :integer         # Hidden 
  #     configure :action_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Person do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :maritalstatus, :belongs_to_association 
  #     configure :country, :belongs_to_association 
  #     configure :state, :belongs_to_association 
  #     configure :city, :belongs_to_association 
  #     configure :image, :has_one_association   #   # Found columns:
  #     configure :user_id, :integer         # Hidden 
  #     configure :firstname, :text 
  #     configure :lastname1, :text 
  #     configure :lastname2, :text 
  #     configure :gender, :boolean 
  #     configure :maritalstatus_id, :integer         # Hidden 
  #     configure :dateofbirth, :date 
  #     configure :country_id, :integer         # Hidden 
  #     configure :state_id, :integer         # Hidden 
  #     configure :city_id, :integer         # Hidden 
  #     configure :photo_filename, :text 
  #     configure :photo_content_type, :text 
  #     configure :other, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :id, :integer 
  #     configure :title, :string   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Prize do
  #   # Found associations:
  #     configure :prizetype, :belongs_to_association 
  #     configure :institution, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :user_prizes, :has_many_association 
  #     configure :users, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :prizetype_id, :integer         # Hidden 
  #     configure :institution_id, :integer         # Hidden 
  #     configure :other, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Prizetype do
  #   # Found associations:
  #     configure :prizes, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Proceeding do
  #   # Found associations:
  #     configure :conference, :belongs_to_association 
  #     configure :publisher, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :inproceedings, :has_many_association 
  #     configure :user_proceedings, :has_many_association 
  #     configure :users, :has_many_association 
  #     configure :versions, :has_many_association         # Hidden   #   # Found columns:
  #     configure :id, :integer 
  #     configure :conference_id, :integer         # Hidden 
  #     configure :title, :text 
  #     configure :year, :integer 
  #     configure :publisher_id, :integer         # Hidden 
  #     configure :isrefereed, :boolean 
  #     configure :volume, :text 
  #     configure :other, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Professionaltitle do
  #   # Found associations:
  #     configure :titlemodality, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :schooling_id, :integer 
  #     configure :titlemodality_id, :integer         # Hidden 
  #     configure :professionalid, :text 
  #     configure :year, :integer 
  #     configure :thesistitle, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Project do
  #   # Found associations:
  #     configure :projecttype, :belongs_to_association 
  #     configure :projectstatus, :belongs_to_association 
  #     configure :project, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :user_projects, :has_many_association 
  #     configure :users, :has_many_association 
  #     configure :projectfinancingsources, :has_many_association 
  #     configure :institutions, :has_many_association 
  #     configure :projectinstitutions, :has_many_association 
  #     configure :projectresearchlines, :has_many_association 
  #     configure :projectresearchareas, :has_many_association 
  #     configure :projectarticles, :has_many_association 
  #     configure :versions, :has_many_association         # Hidden   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :responsible, :text 
  #     configure :descr, :text 
  #     configure :projecttype_id, :integer         # Hidden 
  #     configure :projectstatus_id, :integer         # Hidden 
  #     configure :project_id, :integer         # Hidden 
  #     configure :abstract, :text 
  #     configure :abbrev, :text 
  #     configure :startyear, :integer 
  #     configure :startmonth, :integer 
  #     configure :endyear, :integer 
  #     configure :endmonth, :integer 
  #     configure :url, :text 
  #     configure :other, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Projectacadvisit do
  #   # Found associations:
  #     configure :project, :belongs_to_association 
  #     configure :acadvisit, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :project_id, :integer         # Hidden 
  #     configure :acadvisit_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Projectarticle do
  #   # Found associations:
  #     configure :project, :belongs_to_association 
  #     configure :article, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :project_id, :integer         # Hidden 
  #     configure :article_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Projectconferencetalk do
  #   # Found associations:
  #     configure :project, :belongs_to_association 
  #     configure :conferencetalk, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :project_id, :integer         # Hidden 
  #     configure :conferencetalk_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Projectfinancingsource do
  #   # Found associations:
  #     configure :project, :belongs_to_association 
  #     configure :institution, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :project_id, :integer         # Hidden 
  #     configure :institution_id, :integer         # Hidden 
  #     configure :amount, :decimal 
  #     configure :other, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Projectgenericwork do
  #   # Found associations:
  #     configure :project, :belongs_to_association 
  #     configure :genericwork, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :project_id, :integer         # Hidden 
  #     configure :genericwork_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Projectinstitution do
  #   # Found associations:
  #     configure :project, :belongs_to_association 
  #     configure :institution, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :project_id, :integer         # Hidden 
  #     configure :institution_id, :integer         # Hidden 
  #     configure :other, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Projectresearcharea do
  #   # Found associations:
  #     configure :project, :belongs_to_association 
  #     configure :researcharea, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :project_id, :integer         # Hidden 
  #     configure :researcharea_id, :integer         # Hidden 
  #     configure :other, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Projectresearchline do
  #   # Found associations:
  #     configure :project, :belongs_to_association 
  #     configure :researchline, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :project_id, :integer         # Hidden 
  #     configure :researchline_id, :integer         # Hidden 
  #     configure :other, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Projectstatus do
  #   # Found associations:
  #     configure :projects, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Projectthesis do
  #   # Found associations:
  #     configure :project, :belongs_to_association 
  #     configure :thesis, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :project_id, :integer         # Hidden 
  #     configure :thesis_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Projecttype do
  #   # Found associations:
  #     configure :projects, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Publicationcategory do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :descr, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model PublishedArticle do
  #   # Found associations:
  #     configure :journal, :belongs_to_association 
  #     configure :articlestatus, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :user_articles, :has_many_association 
  #     configure :users, :has_many_association 
  #     configure :versions, :has_many_association         # Hidden   #   # Found columns:
  #     configure :id, :integer 
  #     configure :title, :text 
  #     configure :journal_id, :integer         # Hidden 
  #     configure :articlestatus_id, :integer         # Hidden 
  #     configure :pages, :text 
  #     configure :year, :integer 
  #     configure :month, :integer 
  #     configure :vol, :text 
  #     configure :num, :text 
  #     configure :authors, :text 
  #     configure :url, :text 
  #     configure :pacsnum, :text 
  #     configure :other, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :doi, :text 
  #     configure :is_verified, :boolean 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Publisher do
  #   # Found associations:
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :journals, :has_many_association 
  #     configure :genericworks, :has_many_association 
  #     configure :bookedition_publishers, :has_many_association 
  #     configure :proceedings, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :descr, :text 
  #     configure :url, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model RailsAdminHistory do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :message, :text 
  #     configure :username, :string 
  #     configure :item, :integer 
  #     configure :table, :string 
  #     configure :month, :integer 
  #     configure :year, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model RefereedCriterium do
  #   # Found associations:
  #     configure :user_refereed_journals, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Regularcourse do
  #   # Found associations:
  #     configure :academicprogram, :belongs_to_association 
  #     configure :modality, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :user_regularcourses, :has_many_association 
  #     configure :users, :has_many_association 
  #     configure :periods, :has_many_association 
  #     configure :versions, :has_many_association         # Hidden   #   # Found columns:
  #     configure :id, :integer 
  #     configure :title, :text 
  #     configure :academicprogram_id, :integer         # Hidden 
  #     configure :modality_id, :integer         # Hidden 
  #     configure :semester, :integer 
  #     configure :credits, :integer 
  #     configure :administrative_key, :text 
  #     configure :other, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Researcharea do
  #   # Found associations:
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :researchlines, :has_many_association 
  #     configure :projectresearchareas, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :descr, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Researchgroup do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :descr, :text 
  #     configure :moduser_id, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Researchline do
  #   # Found associations:
  #     configure :researcharea, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :user_researchlines, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :descr, :text 
  #     configure :researcharea_id, :integer         # Hidden 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :name_en, :text 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Review do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :authors, :text 
  #     configure :title, :text 
  #     configure :published_on, :text 
  #     configure :reviewed_work_title, :text 
  #     configure :reviewed_work_publication, :text 
  #     configure :year, :integer 
  #     configure :month, :integer 
  #     configure :other, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Role do
  #   # Found associations:
  #     configure :roleingroups, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :has_group_right, :boolean 
  #     configure :descr, :text 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Roleinbook do
  #   # Found associations:
  #     configure :bookedition_roleinbooks, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Roleinchapter do
  #   # Found associations:
  #     configure :chapterinbook_roleinchapters, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Roleinconference do
  #   # Found associations:
  #     configure :userconferences, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Roleinconferencetalk do
  #   # Found associations:
  #     configure :user_conferencetalks, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Roleincourse do
  #   # Found associations:
  #     configure :user_courses, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Roleingroup do
  #   # Found associations:
  #     configure :group, :belongs_to_association 
  #     configure :role, :belongs_to_association 
  #     configure :permissions, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :group_id, :integer         # Hidden 
  #     configure :role_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Roleinjobposition do
  #   # Found associations:
  #     configure :jobpositioncategories, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Roleinjournal do
  #   # Found associations:
  #     configure :user_journals, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Roleinjury do
  #   # Found associations:
  #     configure :thesis_jurors, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Roleinproject do
  #   # Found associations:
  #     configure :user_projects, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Roleinregularcourse do
  #   # Found associations:
  #     configure :user_regularcourses, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Roleinseminary do
  #   # Found associations:
  #     configure :user_seminaries, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Roleinthesis do
  #   # Found associations:
  #     configure :user_theses, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Roleproceeding do
  #   # Found associations:
  #     configure :user_proceedings, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Schoolarship do
  #   # Found associations:
  #     configure :institution, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :user_schoolarships, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :institution_id, :integer         # Hidden 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Seminary do
  #   # Found associations:
  #     configure :seminarytype, :belongs_to_association 
  #     configure :institution, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :user_seminaries, :has_many_association 
  #     configure :users, :has_many_association 
  #     configure :versions, :has_many_association         # Hidden   #   # Found columns:
  #     configure :id, :integer 
  #     configure :title, :text 
  #     configure :seminarytype_id, :integer         # Hidden 
  #     configure :url, :text 
  #     configure :month, :integer 
  #     configure :year, :integer 
  #     configure :institution_id, :integer         # Hidden 
  #     configure :auditorium, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden 
  #     configure :instructors, :string   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Seminarytype do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model SessionPreference do
  #   # Found associations:
  #     configure :user, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :search_enabled, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Skilltype do
  #   # Found associations:
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :user_skills, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model SponsorAcadvisit do
  #   # Found associations:
  #     configure :acadvisit, :belongs_to_association 
  #     configure :institution, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :acadvisit_id, :integer         # Hidden 
  #     configure :institution_id, :integer         # Hidden 
  #     configure :amount, :decimal 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model State do
  #   # Found associations:
  #     configure :country, :belongs_to_association 
  #     configure :cities, :has_many_association 
  #     configure :people, :has_many_association 
  #     configure :addresses, :has_many_association 
  #     configure :institutions, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :country_id, :integer         # Hidden 
  #     configure :name, :text 
  #     configure :code, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Stimuluslevel do
  #   # Found associations:
  #     configure :stimulustype, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :stimulustype_id, :integer         # Hidden 
  #     configure :registered_by_id, :integer 
  #     configure :modified_by_id, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Stimulustype do
  #   # Found associations:
  #     configure :institution, :belongs_to_association 
  #     configure :stimuluslevels, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :descr, :text 
  #     configure :institution_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Studentrole do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Talkacceptance do
  #   # Found associations:
  #     configure :conferencetalks, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Talktype do
  #   # Found associations:
  #     configure :conferencetalks, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Techproduct do
  #   # Found associations:
  #     configure :techproducttype, :belongs_to_association 
  #     configure :institution, :belongs_to_association 
  #     configure :techproductstatus, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :user_techproducts, :has_many_association 
  #     configure :users, :has_many_association 
  #     configure :versions, :has_many_association         # Hidden   #   # Found columns:
  #     configure :id, :integer 
  #     configure :title, :text 
  #     configure :techproducttype_id, :integer         # Hidden 
  #     configure :authors, :text 
  #     configure :descr, :text 
  #     configure :institution_id, :integer         # Hidden 
  #     configure :techproductstatus_id, :integer         # Hidden 
  #     configure :other, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Techproductstatus do
  #   # Found associations:
  #     configure :techproducts, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Techproducttype do
  #   # Found associations:
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :techproducts, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Thesis do
  #   # Found associations:
  #     configure :institutioncareer, :belongs_to_association 
  #     configure :thesisstatus, :belongs_to_association 
  #     configure :thesismodality, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :career, :belongs_to_association 
  #     configure :user_theses, :has_many_association 
  #     configure :users, :has_many_association 
  #     configure :versions, :has_many_association         # Hidden   #   # Found columns:
  #     configure :id, :integer 
  #     configure :title, :text 
  #     configure :authors, :text 
  #     configure :institutioncareer_id, :integer         # Hidden 
  #     configure :thesisstatus_id, :integer         # Hidden 
  #     configure :thesismodality_id, :integer         # Hidden 
  #     configure :startyear, :integer 
  #     configure :startmonth, :integer 
  #     configure :endyear, :integer 
  #     configure :endmonth, :integer 
  #     configure :other, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden 
  #     configure :career_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model ThesisExamination do
  #   # Found associations:
  #     configure :institutioncareer, :belongs_to_association 
  #     configure :thesisstatus, :belongs_to_association 
  #     configure :thesismodality, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :career, :belongs_to_association 
  #     configure :user_theses, :has_many_association 
  #     configure :users, :has_many_association 
  #     configure :versions, :has_many_association         # Hidden 
  #     configure :thesis_jurors, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :title, :text 
  #     configure :authors, :text 
  #     configure :institutioncareer_id, :integer         # Hidden 
  #     configure :thesisstatus_id, :integer         # Hidden 
  #     configure :thesismodality_id, :integer         # Hidden 
  #     configure :startyear, :integer 
  #     configure :startmonth, :integer 
  #     configure :endyear, :integer 
  #     configure :endmonth, :integer 
  #     configure :other, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden 
  #     configure :career_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model ThesisJuror do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :thesis, :belongs_to_association 
  #     configure :roleinjury, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :thesis_id, :integer         # Hidden 
  #     configure :roleinjury_id, :integer         # Hidden 
  #     configure :year, :integer 
  #     configure :month, :integer 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Thesismodality do
  #   # Found associations:
  #     configure :theses, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Thesisstatus do
  #   # Found associations:
  #     configure :theses, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Titlemodality do
  #   # Found associations:
  #     configure :professionaltitles, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model TutorialCommittee do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :institutioncareer, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :career, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :studentname, :text 
  #     configure :descr, :text 
  #     configure :institutioncareer_id, :integer         # Hidden 
  #     configure :year, :integer 
  #     configure :other, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden 
  #     configure :career_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model User do
  #   # Found associations:
  #     configure :userstatus, :belongs_to_association 
  #     configure :user_incharge, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :person, :has_one_association 
  #     configure :user_group, :has_one_association 
  #     configure :address, :has_one_association 
  #     configure :professional_address, :has_one_association 
  #     configure :jobposition, :has_one_association 
  #     configure :most_recent_jobposition, :has_one_association 
  #     configure :jobposition_for_researching, :has_one_association 
  #     configure :user_identification, :has_one_association 
  #     configure :user_schoolarship, :has_one_association 
  #     configure :user_cite, :has_one_association 
  #     configure :jobposition_log, :has_one_association 
  #     configure :session_preference, :has_one_association 
  #     configure :user_adscriptions, :has_many_association 
  #     configure :jobpositions, :has_many_association 
  #     configure :user_adscription, :has_one_association 
  #     configure :jobposition_as_postdoctoral, :has_one_association 
  #     configure :user_adscription_as_postdoctoral, :has_one_association 
  #     configure :user_schoolarships, :has_many_association 
  #     configure :user_schoolarships_as_posdoctoral, :has_many_association 
  #     configure :documents, :has_many_association 
  #     configure :user_identifications, :has_many_association 
  #     configure :user_researchlines, :has_many_association 
  #     configure :researchlines, :has_many_association 
  #     configure :user_skills, :has_many_association 
  #     configure :user_articles, :has_many_association 
  #     configure :articles, :has_many_association 
  #     configure :published_articles, :has_many_association 
  #     configure :recent_published_articles, :has_many_association 
  #     configure :inprogress_articles, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :login, :text 
  #     configure :password, :password         # Hidden 
  #     configure :password_confirmation, :password         # Hidden 
  #     configure :password_salt, :text         # Hidden 
  #     configure :reset_password_token, :string         # Hidden 
  #     configure :remember_token, :string         # Hidden 
  #     configure :userstatus_id, :integer         # Hidden 
  #     configure :email, :text 
  #     configure :homepage, :text 
  #     configure :blog, :text 
  #     configure :calendar, :text 
  #     configure :pkcs7, :text 
  #     configure :token, :text 
  #     configure :token_expiry, :datetime 
  #     configure :user_incharge_id, :integer         # Hidden 
  #     configure :modified_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :author_name, :text 
  #     configure :current_sign_in_ip, :string 
  #     configure :last_sign_in_ip, :string 
  #     configure :remember_created_at, :datetime 
  #     configure :current_sign_in_at, :datetime 
  #     configure :last_sign_in_at, :datetime 
  #     configure :sign_in_count, :integer 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :homepage_resume, :text 
  #     configure :homepage_resume_en, :text 
  #     configure :failed_attempts, :integer 
  #     configure :locked_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserAdscription do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :jobposition, :belongs_to_association 
  #     configure :adscription, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :jobposition_id, :integer         # Hidden 
  #     configure :adscription_id, :integer         # Hidden 
  #     configure :name, :text 
  #     configure :descr, :text 
  #     configure :startmonth, :integer 
  #     configure :startyear, :integer 
  #     configure :endmonth, :integer 
  #     configure :endyear, :integer 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :start_date, :date 
  #     configure :end_date, :date   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserArticle do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :article, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :article_id, :integer         # Hidden 
  #     configure :ismainauthor, :boolean 
  #     configure :other, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserCite do
  #   # Found associations:
  #     configure :user, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :author_name, :text 
  #     configure :total, :integer 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserCitesLog do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :total, :integer 
  #     configure :year, :integer 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserConferencetalk do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :conferencetalk, :belongs_to_association 
  #     configure :roleinconferencetalk, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :conferencetalk_id, :integer         # Hidden 
  #     configure :roleinconferencetalk_id, :integer         # Hidden 
  #     configure :comment, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserCourse do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :course, :belongs_to_association 
  #     configure :roleincourse, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :course_id, :integer         # Hidden 
  #     configure :roleincourse_id, :integer         # Hidden 
  #     configure :other, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserCredit do
  #   # Found associations:
  #     configure :credittype, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :credittype_id, :integer         # Hidden 
  #     configure :descr, :text 
  #     configure :other, :text 
  #     configure :year, :integer 
  #     configure :month, :integer 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserCreditsarticle do
  #   # Found associations:
  #     configure :article, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :article_id, :integer         # Hidden 
  #     configure :other, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserCreditsbookedition do
  #   # Found associations:
  #     configure :bookedition, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :bookedition_id, :integer         # Hidden 
  #     configure :other, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserCreditsconferencetalk do
  #   # Found associations:
  #     configure :conferencetalk, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :conferencetalk_id, :integer         # Hidden 
  #     configure :other, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserCreditsgenericwork do
  #   # Found associations:
  #     configure :genericwork, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :genericwork_id, :integer         # Hidden 
  #     configure :other, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserDocument do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :document, :belongs_to_association 
  #     configure :documenttype, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :document_id, :integer         # Hidden 
  #     configure :user_incharge_id, :integer 
  #     configure :status, :boolean 
  #     configure :filename, :text 
  #     configure :content_type, :text 
  #     configure :ip_address, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :documenttype_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserGenericwork do
  #   # Found associations:
  #     configure :genericwork, :belongs_to_association 
  #     configure :user, :belongs_to_association 
  #     configure :userrole, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :genericwork_id, :integer         # Hidden 
  #     configure :user_id, :integer         # Hidden 
  #     configure :userrole_id, :integer         # Hidden 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserGroup do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :group, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :group_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserIdentification do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :idtype, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :descr, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :idtype_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserInproceeding do
  #   # Found associations:
  #     configure :inproceeding, :belongs_to_association 
  #     configure :user, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :inproceeding_id, :integer         # Hidden 
  #     configure :user_id, :integer         # Hidden 
  #     configure :ismainauthor, :boolean 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserJournal do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :journal, :belongs_to_association 
  #     configure :roleinjournal, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :journal_id, :integer         # Hidden 
  #     configure :roleinjournal_id, :integer         # Hidden 
  #     configure :startyear, :integer 
  #     configure :startmonth, :integer 
  #     configure :endyear, :integer 
  #     configure :endmonth, :integer 
  #     configure :other, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserLanguage do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :language, :belongs_to_association 
  #     configure :spoken_languagelevel, :belongs_to_association 
  #     configure :written_languagelevel, :belongs_to_association 
  #     configure :institution, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :language_id, :integer         # Hidden 
  #     configure :spoken_languagelevel_id, :integer         # Hidden 
  #     configure :written_languagelevel_id, :integer         # Hidden 
  #     configure :institution_id, :integer         # Hidden 
  #     configure :other, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserNewspaperarticle do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :newspaperarticle, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :newspaperarticle_id, :integer         # Hidden 
  #     configure :ismainauthor, :boolean 
  #     configure :other, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserPrize do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :prize, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :prize_id, :integer         # Hidden 
  #     configure :year, :integer 
  #     configure :month, :integer 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserProceeding do
  #   # Found associations:
  #     configure :proceeding, :belongs_to_association 
  #     configure :user, :belongs_to_association 
  #     configure :roleproceeding, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :proceeding_id, :integer         # Hidden 
  #     configure :user_id, :integer         # Hidden 
  #     configure :roleproceeding_id, :integer         # Hidden 
  #     configure :comment, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserProject do
  #   # Found associations:
  #     configure :project, :belongs_to_association 
  #     configure :user, :belongs_to_association 
  #     configure :roleinproject, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :project_id, :integer         # Hidden 
  #     configure :user_id, :integer         # Hidden 
  #     configure :roleinproject_id, :integer         # Hidden 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserRefereedJournal do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :journal, :belongs_to_association 
  #     configure :refereed_criterium, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :journal_id, :integer         # Hidden 
  #     configure :refereed_criterium_id, :integer         # Hidden 
  #     configure :refereed_title, :text 
  #     configure :year, :integer 
  #     configure :month, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserRegularcourse do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :regularcourse, :belongs_to_association 
  #     configure :period, :belongs_to_association 
  #     configure :roleinregularcourse, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :regularcourse_id, :integer         # Hidden 
  #     configure :period_id, :integer         # Hidden 
  #     configure :roleinregularcourse_id, :integer         # Hidden 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :hoursxweek, :float 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserResearchline do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :researchline, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :researchline_id, :integer         # Hidden 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserRoleingroup do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :roleingroup, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :roleingroup_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserSchoolarship do
  #   # Found associations:
  #     configure :schoolarship, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :schoolarship_id, :integer         # Hidden 
  #     configure :user_id, :integer 
  #     configure :descr, :text 
  #     configure :amount, :decimal 
  #     configure :start_date, :date 
  #     configure :end_date, :date 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserSeminary do
  #   # Found associations:
  #     configure :seminary, :belongs_to_association 
  #     configure :user, :belongs_to_association 
  #     configure :roleinseminary, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :seminary_id, :integer         # Hidden 
  #     configure :user_id, :integer         # Hidden 
  #     configure :roleinseminary_id, :integer         # Hidden 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserSkill do
  #   # Found associations:
  #     configure :skilltype, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :skilltype_id, :integer         # Hidden 
  #     configure :descr, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :descr_en, :text 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserStimulus do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :stimuluslevel, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :stimuluslevel_id, :integer         # Hidden 
  #     configure :startyear, :integer 
  #     configure :startmonth, :integer 
  #     configure :endyear, :integer 
  #     configure :endmonth, :integer 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserTechproduct do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :techproduct, :belongs_to_association 
  #     configure :userrole, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :techproduct_id, :integer         # Hidden 
  #     configure :userrole_id, :integer         # Hidden 
  #     configure :year, :integer 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserThesis do
  #   # Found associations:
  #     configure :thesis, :belongs_to_association 
  #     configure :user, :belongs_to_association 
  #     configure :roleinthesis, :belongs_to_association 
  #     configure :registered_by, :belongs_to_association 
  #     configure :modified_by, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :thesis_id, :integer         # Hidden 
  #     configure :user_id, :integer         # Hidden 
  #     configure :roleinthesis_id, :integer         # Hidden 
  #     configure :other, :text 
  #     configure :registered_by_id, :integer         # Hidden 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime 
  #     configure :modified_by_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Userconference do
  #   # Found associations:
  #     configure :conference, :belongs_to_association 
  #     configure :user, :belongs_to_association 
  #     configure :roleinconference, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :conference_id, :integer         # Hidden 
  #     configure :user_id, :integer         # Hidden 
  #     configure :roleinconference_id, :integer         # Hidden 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Userrole do
  #   # Found associations:
  #     configure :user_genericworks, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Userstatus do
  #   # Found associations:
  #     configure :users, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Volume do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :text 
  #     configure :moduser_id, :integer 
  #     configure :created_on, :datetime 
  #     configure :updated_on, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
end
