class Identification < ActiveRecord::Base
validates_presence_of :idtype_id, :citizen_country_id
validates_numericality_of :idtype_id, :citizen_country_id
belongs_to :idtype
belongs_to :citizen_country, :class_name => 'Country', :foreign_key => 'citizen_country_id'
end
