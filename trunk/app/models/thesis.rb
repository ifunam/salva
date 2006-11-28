class Thesis < ActiveRecord::Base
validates_presence_of :title, :authors, :degree_id, :thesisstatus_id, :thesismodality_id, :institutioncareer_id, :year
validates_numericality_of :degree_id, :thesisstatus_id, :thesismodality_id, :institutioncareer_id
belongs_to :degree
belongs_to :thesisstatus
belongs_to :thesismodality
belongs_to :institutioncareer
end
