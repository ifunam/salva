class Activitygroup < ActiveRecord::Base
validates_numericality_of :id, :only_integer => true

end
