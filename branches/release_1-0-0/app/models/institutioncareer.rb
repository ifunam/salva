class Institutioncareer < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :institution_id, :career_id, :greater_than =>0, :allow_nil => true, :only_integer => true
  belongs_to :institution
  belongs_to :career
end
