class Coursegroup < ActiveRecord::Base
validates_presence_of :name, :coursegrouptype_id, :startyear
validates_numericality_of :coursegrouptype_id
belongs_to :coursegrouptype
end
