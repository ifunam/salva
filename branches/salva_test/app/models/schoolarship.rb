class Schoolarship < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :id, :institution_id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :institution_id, :allow_nil => true, :only_integer => true

  validates_uniqueness_of :name

  belongs_to :institution
  validates_associated :institution
end

