class Conferencetalk < ActiveRecord::Base
validates_presence_of :title, :authors, :conference_id, :talktype_id, :talkacceptance_id, :modality_id
validates_numericality_of :conference_id, :talktype_id, :talkacceptance_id, :modality_id
belongs_to :conference
belongs_to :talktype
belongs_to :talkacceptance
belongs_to :modality
end
