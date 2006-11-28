class StudentThesis < ActiveRecord::Base
validates_presence_of :thesis_id
validates_numericality_of :thesis_id
belongs_to :thesis
end
