class Chapterinbook < ActiveRecord::Base
validates_presence_of :bookedition_id, :bookchaptertype_id, :title
validates_numericality_of :bookedition_id, :bookchaptertype_id
belongs_to :bookedition
belongs_to :bookchaptertype
end
