class Projectacadvisit < ActiveRecord::Base
validates_presence_of :project_id, :acadvisit_id
validates_numericality_of :project_id, :acadvisit_id
belongs_to :project
belongs_to :acadvisit
end
