class Techproduct < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :institution_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :techproductstatus_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :techproducttype_id, :allow_nil => true, :only_integer => true

  validates_presence_of :title, :authors
  belongs_to :techproducttype
  belongs_to :techproductstatus
  belongs_to :institution
  has_many :user_techproducts 
end
