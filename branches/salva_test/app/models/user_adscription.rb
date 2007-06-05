class UserAdscription < ActiveRecord::Base
validates_presence_of :jobposition_id, :adscription_id, :startyear
validates_numericality_of :jobposition_id, :adscription_id
belongs_to :jobposition
belongs_to :adscription
end
