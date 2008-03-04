class UserCredit < ActiveRecord::Base
validates_presence_of :credittype_id, :descr, :year
validates_numericality_of :credittype_id
belongs_to :credittype
end
