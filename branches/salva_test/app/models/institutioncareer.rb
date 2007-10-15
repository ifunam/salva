class Institutioncareer < ActiveRecord::Base
  validates_presence_of :institution_id, :career_id
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :institution_id, :career_id, :greater_than =>0, :only_integer => true


  validates_uniqueness_of :institution_id, :scope => [:career_id]

  belongs_to :institution
  belongs_to :career

 validates_associated :career
 validates_associated :institution

end
