class UserGrant < ActiveRecord::Base
validates_presence_of :grant_id, :startyear
validates_numericality_of :grant_id
belongs_to :grant
end
