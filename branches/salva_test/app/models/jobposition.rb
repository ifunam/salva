class Jobposition < ActiveRecord::Base
  set_table_name "jobpositions"
  
  validates_presence_of :user_id, :institution_id, :startyear
  validates_numericality_of :institution_id #:jobpositioncategory_id, :contracttype_id, 

  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :institution_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :startyear, :only_integer => true

  validates_uniqueness_of :user_id, :scope => [:institution_id, :startyear]

  belongs_to :jobpositioncategory
  belongs_to :contracttype
  belongs_to :institution
  belongs_to :user
  has_many :user_adscriptions
end
