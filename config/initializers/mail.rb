Rails.application.configure do
  config.before_initialize do

    conf_path = File.join(Rails.root.to_s, 'config', 'mail.yml')

    if File.exists? conf_path and !Rails.env.test?
      settings = YAML.load_file(conf_path)
      settings.merge!(:arguments => "-i -t -f noreply@#{settings[:domain]}")

      config.action_mailer.delivery_method = :sendmail
      config.action_mailer.smtp_settings = settings
      config.action_mailer.perform_deliveries = true
      config.action_mailer.raise_delivery_errors = true
    else
      warn "You must configure #{conf_path}, copy the config/mail.yml.example file"
    end

  end
end
