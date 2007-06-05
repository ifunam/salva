class UserThesis < ActiveRecord::Base
validates_presence_of :thesis_id, :roleinthesis_id
validates_numericality_of :thesis_id, :roleinthesis_id
belongs_to :thesis
belongs_to :roleinthesis
end
