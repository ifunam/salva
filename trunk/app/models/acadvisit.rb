class Acadvisit < ActiveRecord::Base
validates_presence_of :institution_id, :country_id, :acadvisittype_id, :name, :startyear
validates_numericality_of :institution_id, :country_id, :acadvisittype_id
belongs_to :institution
belongs_to :country
belongs_to :acadvisittype
end
