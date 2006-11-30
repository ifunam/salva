class Regularcourse < ActiveRecord::Base
validates_presence_of :name, :institutioncareer_id, :courseduration_id, :modality_id
validates_numericality_of :institutioncareer_id, :courseduration_id, :modality_id
belongs_to :institutioncareer
belongs_to :courseduration
belongs_to :modality
  attr_accessor :degree_id
end
