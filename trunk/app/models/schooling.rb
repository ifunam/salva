class Schooling < ActiveRecord::Base
  attr_accessor :degree_id

  validates_presence_of :institutioncareer_id, :credential_id, :startyear
  validates_numericality_of :institutioncareer_id, :credential_id

  belongs_to :credential
  belongs_to :institutioncareer
end
