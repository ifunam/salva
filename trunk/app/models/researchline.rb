class Researchline < ActiveRecord::Base
validates_presence_of :name
validates_numericality_of :researcharea_id
belongs_to :researcharea
end
