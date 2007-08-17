class Institutioncareer < ActiveRecord::Base
  validates_presence_of :institution_id, :career_id
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :institution_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :career_id, :allow_nil => true, :only_integer => true

  validates_uniqueness_of :institution_id, :scope => [:career_id], :message => 'La carrera en institucion esta duplicada'

  belongs_to :institution
  belongs_to :career
end
