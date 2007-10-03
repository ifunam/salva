class Thesis < ActiveRecord::Base
  validates_presence_of :institutioncareer_id, :thesisstatus_id, :thesismodality_id, :startyear, :authors, :title
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :institutioncareer_id, :thesisstatus_id, :thesismodality_id, :startyear,  :greater_than => 0, :only_integer => true
  validates_uniqueness_of :title, :scope => [:institutioncareer_id, :startyear]

  belongs_to :thesisstatus
  belongs_to :thesismodality
  belongs_to :institutioncareer

  validates_associated :thesisstatus
  validates_associated :thesismodality
  validates_associated :institutioncareer
end
