class TutorialCommittee < ActiveRecord::Base
validates_presence_of :studentname, :degree_id, :institutioncareer_id, :year
validates_numericality_of :degree_id, :institutioncareer_id
belongs_to :degree
belongs_to :institutioncareer
end
