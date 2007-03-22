class Regularcourse < ActiveRecord::Base
validates_presence_of :title, :modality_id
validates_numericality_of :academicprogram_id, :modality_id
belongs_to :academicprogram
belongs_to :modality
end
