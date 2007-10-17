class Techproduct < ActiveRecord::Base
  validates_presence_of :title, :authors
  validates_numericality_of :id, :allow_nil => true,  :greater_than => 0, :only_integer => true
  validates_numericality_of :institution_id, :allow_nil => true,  :greater_than => 0, :only_integer => true
  validates_numericality_of :techproducttype_id, :techproductstatus_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of   :title
  
  belongs_to :techproducttype
  belongs_to :techproductstatus
  belongs_to :institution
end
