class Acadvisit < ActiveRecord::Base

validates_presence_of :institution_id, :country_id, :acadvisittype_id, :descr, :startyear, :user_id
validates_numericality_of :id, :allow_nil => true, :only_integer => true
validates_numericality_of :institution_id, :allow_nil => true, :only_integer => true
validates_numericality_of :country_id, :only_integer => true
validates_numericality_of :user_id, :only_integer => true
validates_numericality_of :acadvisittype_id, :only_integer => true
validates_uniqueness_of :descr

belongs_to :institution
belongs_to :country
belongs_to :acadvisittype

end
