class Indivadviceprogram < ActiveRecord::Base
validates_presence_of :name, :institution_id
validates_numericality_of :institution_id
belongs_to :institution
end
