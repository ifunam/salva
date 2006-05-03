class Institutioncareer < ActiveRecord::Base
  attr_accessor :name, :abbrev
  validates_presence_of :institution_id, :degree_id, :career_id
  validates_numericality_of :institution_id, :degree_id, :career_id
  belongs_to :institution
  belongs_to :degree
  belongs_to :career
end
