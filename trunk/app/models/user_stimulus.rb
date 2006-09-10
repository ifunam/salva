class UserStimulus < ActiveRecord::Base
validates_presence_of :startyear
validates_numericality_of :stimuluslevel_id
belongs_to :stimuluslevel
end
