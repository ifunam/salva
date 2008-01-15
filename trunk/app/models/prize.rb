 class Prize < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true,  :greater_than =>0, :only_integer => true
  validates_presence_of :name
  belongs_to :prizetype
  belongs_to :institution
  
  validates_associated :prizetype
end
