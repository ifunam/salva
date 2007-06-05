class ThesisJuror < ActiveRecord::Base
validates_presence_of :thesis_id, :roleinjury_id, :year
validates_numericality_of :thesis_id, :roleinjury_id
belongs_to :thesis
belongs_to :roleinjury
end
