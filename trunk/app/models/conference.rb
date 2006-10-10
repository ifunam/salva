class Conference < ActiveRecord::Base
validates_presence_of :name, :year, :conferencetype_id, :country_id, :conferencescope_id
validates_numericality_of :conferencetype_id, :country_id, :conferencescope_id
belongs_to :conferencetype
belongs_to :country
belongs_to :conferencescope
end
