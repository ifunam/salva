class Jobposition < ActiveRecord::Base
  set_table_name "jobpositions"

  validates_presence_of :institution_id, :startyear
  validates_numericality_of :institution_id #:jobpositioncategory_id, :contracttype_id,

  belongs_to :jobpositioncategory
  belongs_to :contracttype
  belongs_to :institution
  has_many :user_adscriptions
end
