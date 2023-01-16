require 'machinist/active_record'
['catalogs', 'users', 'people', 'images', 'addresses', 'user_groups', 'jobpositions', 'user_adscriptions'].each do |bp|
  require_relative "../blueprints/#{bp}.rb"
end
