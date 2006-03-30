class Peopleid < ActiveRecord::Base

validates_presence_of :personalidtype_id
validates_numericality_of :personalidtype_id
belongs_to :personalidtype

end

