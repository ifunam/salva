class Projectconferencetalk < ActiveRecord::Base
validates_presence_of :project_id, :conferencetalk_id
validates_numericality_of :project_id, :conferencetalk_id
belongs_to :project
belongs_to :conferencetalk
end
