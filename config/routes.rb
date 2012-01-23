%w(base admin academic_secretary web_site academic api).each do |routes|
  load Rails.root.join("config/routes/#{routes}.rb")
end
