class Citizen < ActiveRecord::Base

validates_presence_of :citizen_country_id
validates_numericality_of :migratorystatus_id, :citizen_country_id
belongs_to :migratorystatus
belongs_to :citizen_country, :class_name => 'Country', :foreign_key => 'citizen_country_id'

end

