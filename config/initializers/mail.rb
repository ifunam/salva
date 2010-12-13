if Rails.env.to_s != 'test'
  Salva::Application.configure do
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = { 
      :enable_starttls_auto => false,
      :address => 'fenix.fisica.unam.mx',
      :port => 25,
      :domain => 'fisica.unam.mx',
      :location => '/usr/sbin/sendmail',
      :arguments => '-i -t -f noreply@fisica.unam.mx'
    }
  end
end
