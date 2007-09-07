class Thesis < ActiveRecord::Base
  validates_presence_of :title, :authors, :thesisstatus_id, :thesismodality_id, :institutioncareer_id, :startyear
  validates_numericality_of :thesisstatus_id, :thesismodality_id, :institutioncareer_id
  validates_uniqueness_of :title, :scope => [:institutioncareer_id, :startyear]
  belongs_to :thesisstatus
  belongs_to :thesismodality
  belongs_to :institutioncareer

  has_many :projecttheses
end
