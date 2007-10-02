class Projectresearchline < ActiveRecord::Base
validates_presence_of :project_id, :researchline_id
validates_numericality_of :project_id, :researchline_id
belongs_to :project
belongs_to :researchline
end
