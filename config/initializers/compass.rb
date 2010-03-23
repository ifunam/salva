require 'compass'
rails_root = (defined?(Rails) ? Rails.root : RAILS_ROOT).to_s
Compass.add_project_configuration(File.join(rails_root, "config", "compass.rb"))
Compass.configure_sass_plugin!
Compass.handle_configuration_change!

# added to make sure sass has the sass-cache directory
FileUtils.mkdir_p Rails.root.join("tmp", "sass-cache").to_s
Sass::Plugin.options[:cache_location] ||= Rails.root.join("tmp", "sass-cache").to_s