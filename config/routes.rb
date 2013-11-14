if ActiveRecord::Schema.tables.include? 'schema_migrations'
  %w(base web_site academic api admin librarian).each do |routes|
    load Rails.root.join("config/routes/#{routes}.rb")
  end
end
