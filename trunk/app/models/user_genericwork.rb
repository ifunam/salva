class UserGenericwork < ActiveRecord::Base
validates_presence_of :genericwork_id, :user_is_internal, :userrole_id
validates_numericality_of :genericwork_id, :userrole_id
belongs_to :genericwork
belongs_to :userrole
end
