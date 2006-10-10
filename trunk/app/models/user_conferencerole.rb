class UserConferencerole < ActiveRecord::Base
validates_presence_of :userconference_id, :attendeetype_id
validates_numericality_of :userconference_id, :attendeetype_id, :conferencetalk_id
belongs_to :userconference
belongs_to :attendeetype
belongs_to :conferencetalk
end
