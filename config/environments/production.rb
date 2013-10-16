require 'uglifier'
require 'css_image_embedder'
include Salva::SiteConfig
Salva::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # Generate digests for assets URLs
  config.assets.digest = true

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true
  config.ssl_options = { :exclude => proc { |env| env['PATH_INFO'].start_with?('/web_site') } }

  # See everything in the log (default is :info)
  config.log_level = :debug

  # Prepend all log lines with the following tags
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)
  #

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store
  config.cache_store = :dalli_store, "127.0.0.1:11211",
                { :namespace => "SALVA", :expires_in => 1.day, :compress => true }

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # config.assets.precompile += %w( search.js )
  config.assets.precompile += %w( screen.css print.css ie.css devise.css devise.js user_resources.css
                                  user_resources.js publications.css publications.js academic.css
                                  academic.js web_site.css web_site.js home_page.css admin.css
                                  active_admin.js active_admin.css)

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Compress both stylesheets and JavaScripts
  config.assets.js_compressor  = :uglifier
  config.assets.css_compressor = CssImageEmbedder::Compressor.new(File.join(Rails.root, 'public'))
  config.sass.line_comments = false
  config.sass.syntax = :nested

  # Exception notification
  conf_path = File.join(Rails.root.to_s, 'config', 'mail.yml')
  if File.exists? conf_path
    config.action_mailer.delivery_method = :sendmail
    config.middleware.use ExceptionNotifier,
      :email_prefix => "[SALVA - Exception notification] ",
      :sender_address =>  Salva::SiteConfig.system('email'),
      :exception_recipients => Salva::SiteConfig.admin('email')
  end
  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5
  config.action_mailer.default_url_options = { :host => "salva.fisica.unam.mx" }
end
