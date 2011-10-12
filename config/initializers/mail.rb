if Rails.env.to_s != 'test'
  Salva::Application.configure do
    config.action_mailer.delivery_method = :smtp
    conf_path = File.join(Rails.root.to_s, 'config', 'mail.yml')
    if File.exists? conf_path
      settings = YAML.load_file(conf_path)
      settings.merge!(:arguments => "-i -t -f noreply@#{settings[:domain]}")
      config.action_mailer.smtp_settings = settings
    else
      warn "You must configure #{conf_path}, copy the config/mail.yml.example file"
    end
  end
end
