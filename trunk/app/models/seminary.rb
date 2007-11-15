class Seminary < ActiveRecord::Base
  validates_presence_of :title, :year, :institution_id, :seminarytype_id
 validates_numericality_of :seminarytype_id, :institution_id, :year,  :greater_than =>0, :only_integer => true
 validates_numericality_of :id, :month, :allow_nil => true, :greater_than =>0, :only_integer => true

 validates_uniqueness_of :title, :scope => [:year, :institution_id]

 belongs_to :institution
 belongs_to :seminarytype
 validates_associated :institution

end
