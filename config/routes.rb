if ActiveRecord::Schema.tables.include? 'schema_migrations'
  %w(base web_site bi academic department api admin librarian).each do |routes|
    load Rails.root.join("config/routes/#{routes}.rb")
  end
end
