class InstitutionalActivity < ActiveRecord::Base
validates_presence_of :descr, :institution_id, :startyear
validates_numericality_of :institution_id
belongs_to :institution
end
