class Jobpositioncategory < ActiveRecord::Base
validates_presence_of :jobpositiontype_id, :roleinjobposition_id, :jobpositionlevel_id
validates_numericality_of :jobpositiontype_id, :roleinjobposition_id, :jobpositionlevel_id
belongs_to :jobpositiontype
belongs_to :roleinjobposition
belongs_to :jobpositionlevel
end
