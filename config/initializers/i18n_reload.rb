# config/initializers/i18n_reload.rb
Rails.configuration.after_initialize do
  I18n.reload!
end
