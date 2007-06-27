class Projectinstitution < ActiveRecord::Base
attr_accessor :country_id
validates_presence_of :project_id, :institution_id
validates_numericality_of :project_id, :institution_id
belongs_to :project
belongs_to :institution
end
