class Seminary < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :institution_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :year, :allow_nil => true, :only_integer => true
  validates_inclusion_of :isseminary, :in=> [true, false]
  validates_inclusion_of :month, :in => 1..12

  validates_presence_of :title, :year, :institution_id, :isseminary
  validates_uniqueness_of :title, :scope => [:institution_id, :year]
  belongs_to :institution
end
