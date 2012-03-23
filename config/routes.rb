%w(base web_site academic api admin).each do |routes|
  load Rails.root.join("config/routes/#{routes}.rb")
end
