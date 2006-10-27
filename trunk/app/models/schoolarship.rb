class Schoolarship < ActiveRecord::Base
validates_presence_of :name
validates_numericality_of :institution_id
belongs_to :institution
end
