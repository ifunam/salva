%w(site_config routes meta_search_extension).each do |file|
  require  Rails.root.to_s + '/lib/salva/' + file
end
