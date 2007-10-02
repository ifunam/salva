class Projectthesis < ActiveRecord::Base
validates_presence_of :project_id, :thesis_id
validates_numericality_of :project_id, :thesis_id
belongs_to :project
belongs_to :thesis
end
