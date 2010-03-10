class Thesis < ActiveRecord::Base
  validates_presence_of :thesisstatus_id, :thesismodality_id, :startyear, :authors, :title
  validates_numericality_of :id,:institutioncareer_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :thesisstatus_id, :thesismodality_id, :startyear,  :greater_than => 0, :only_integer => true

  belongs_to :thesisstatus
  belongs_to :thesismodality
  belongs_to :institutioncareer
end
