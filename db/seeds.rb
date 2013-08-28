# encoding: utf-8
require 'csv'
data_dir = File.join(Rails.root.to_s, 'db', 'data')

Userstatus.destroy_all
CSV.foreach("#{data_dir}/userstatuses.csv", :headers => false) do |row|
  Userstatus.create name: row[0].to_s.strip
end

