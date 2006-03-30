class Peopleid < ActiveRecord::Base

validates_presence_of :idcitizen_id
validates_numericality_of :idcitizen_id
belongs_to :idcitizen

end

