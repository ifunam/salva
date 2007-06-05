class Institutioncareer < ActiveRecord::Base
  attr_accessor :name, :abbrev, :degree_id
  validates_presence_of :institution_id, :career_id
  validates_numericality_of :institution_id, :career_id
  belongs_to :institution
  belongs_to :career
end
