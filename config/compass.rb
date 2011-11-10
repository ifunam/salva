# This configuration file works with both the Compass command line tool and within Rails.
# Require any additional compass plugins here.
project_type = :rails
project_path = RAILS_ROOT if defined?(RAILS_ROOT)
# Set this to the root of your project when deployed:
http_path = "/"
css_dir = "app/assets/stylesheets"
sass_dir = "app/sass"
images_dir = "app/assets/images"
javascripts_dir = "app/assets/javascripts"
environment = Compass::AppIntegration::Rails.env
# To enable relative paths to assets via compass helper functions. Uncomment:
# relative_assets = true
