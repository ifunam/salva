class Stimuluslevel < ActiveRecord::Base
validates_presence_of :name, :stimulustype_id
validates_numericality_of :stimulustype_id
belongs_to :stimulustype
end
