class UserSeminary < ActiveRecord::Base
validates_presence_of :seminary_id, :roleinseminary_id
validates_numericality_of :seminary_id, :roleinseminary_id
belongs_to :seminary
belongs_to :roleinseminary
end
