class UserRegularcourse < ActiveRecord::Base
attr_accessor :academicprogram_id
validates_presence_of :regularcourse_id, :roleinregularcourse_id, :period_id
validates_numericality_of :regularcourse_id, :period_id, :roleinregularcourse_id
belongs_to :regularcourse
belongs_to :period
belongs_to :roleinregularcourse
end
