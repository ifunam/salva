class Projectgenericwork < ActiveRecord::Base
validates_presence_of :project_id, :genericwork_id
validates_numericality_of :project_id, :genericwork_id
belongs_to :project
belongs_to :genericwork
end
