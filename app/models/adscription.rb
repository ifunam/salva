class Adscription < ActiveRecord::Base
  validates_presence_of :name, :institution_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :institution_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name, :scope => [:institution_id]
  belongs_to :institution
  has_many :user_adscriptions
  
  default_scope :order => 'name ASC'
end
