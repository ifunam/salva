Salva::Application.configure do
  config.before_initialize do
    config.autoload_paths += %W(#{config.root}/lib/salva)

    %w(routes meta_user_association site_config meta_date_extension).each do |file|
      file_path = Rails.root.to_s + '/lib/salva/' + file
      require file_path if File.exist? "#{file_path}.rb"
    end
  end 

  config.after_initialize do
    %w(meta_search_extension).each do |file|
      file_path = Rails.root.to_s + '/lib/salva/' + file
      require file_path if File.exist? "#{file_path}.rb"
    end

    if Rails.env.to_s == 'production'
      require Rails.root.to_s + '/lib/salva/exception_notifier_extension'
    end
  end
end
