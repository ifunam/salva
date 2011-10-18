Salva::Application.configure do
  config.before_initialize do
    %w(routes meta_user_association).each do |file|
      file_path = Rails.root.to_s + '/lib/salva/' + file
      require file_path if File.exist? "#{file_path}.rb"
    end
  end 

  config.after_initialize do
    %w(site_config meta_search_extension meta_date_extension).each do |file|
      file_path = Rails.root.to_s + '/lib/salva/' + file
      require file_path if File.exist? "#{file_path}.rb"
    end
    MetaWhere.operator_overload!
  end
end
