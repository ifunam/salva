# Be sure to restart your server when you modify this file.

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
# RAILS_GEM_VERSION = '1.2.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here

  # Skip frameworks you're not going to use (only works if using vendor/rails)
  # config.frameworks -= [ :active_resource, :action_mailer ]

  # Only load the plugins named here, in the order given. By default, all plugins in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named.
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Add additional load paths for your own custom dirs
  config.load_paths += %W( #{RAILS_ROOT}/lib )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  config.action_controller.session = {
    :session_key => '_test_session',
    :secret      => '5ce5d03f910eff3c73b65444e6cc84fb'
  }

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with 'rake db:sessions:create')
  config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector
  config.active_record.observers = :user_observer
  
  # Make Active Record use UTC-base instead of local time
  # config.active_record.default_timezone = :utc
  config.active_record.default_timezone = :local
  config.active_record.record_timestamps = true

  # See Rails::Configuration for more options

  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded
end

ActiveRecord::Errors.default_error_messages = {
    :not_a_number=>"no es un número", 
    :odd=>"debe ser impar", 
    :blank=>"no puede estar en blanco", 
    :greater_than=>"debe ser mayor a  %d",
    :inclusion=>"no esta incluído en la lista",
    :even=>"debe ser mayor",
    :too_long=>"es muy grande (debe tener un máximo de %d caracteres )",
    :greater_than_or_equal_to=>"debe ser mayor o igual a %d",
    :empty=>"no puede estar vacío",
    :exclusion=>"esta reservado", 
    :too_short=>"es muy corto (debe tener un minímo de %d caracteres)", 
    :equal_to=>"debe ser igual a %d",
    :invalid=>"es inválido",
    :wrong_length=>"es incorrecto la longitud (debe ser de %d caracteres)", 
    :less_than=>"debe ser menor a %d",
    :confirmation=>"la confirmación no coincide",
    :taken=>"ya ha sido seleccionado", 
    :less_than_or_equal_to=>"debe ser menor o igual a %d",
    :accepted=>"debe aceptarse"
}
# ActionMailer configuration:
# http://api.rubyonrails.com/classes/ActionMailer/Base.html
if RAILS_ENV != 'test'
  begin
    mail_settings = YAML.load(File.read("#{RAILS_ROOT}/config/mail.yml"))
    ActionMailer::Base.delivery_method = mail_settings['method'].to_sym
    ActionMailer::Base.default_charset = mail_settings['charset']
    ActionMailer::Base.smtp_settings = mail_settings['settings']
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.raise_delivery_errors = true
  rescue
    # Fall back to using sendmail by default
    ActionMailer::Base.delivery_method = :sendmail
  end
end

# Configuration for date displaying
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS[:default]='%d/%m/%Y'
