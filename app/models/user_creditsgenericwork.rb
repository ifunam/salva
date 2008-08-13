class UserCreditsgenericwork < ActiveRecord::Base
validates_presence_of :genericwork_id
validates_numericality_of :genericwork_id
belongs_to :genericwork
end
