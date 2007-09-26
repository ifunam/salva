class UserGenericwork  < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :genericwork_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :userrole_id, :allow_nil => true, :only_integer => true
  validates_presence_of :genericwork_id, :userrole_id, :user_id
  validates_uniqueness_of :user_id, :scope => [:genericwork_id, :userrole_id]

  belongs_to :genericwork
  belongs_to :userrole
  belongs_to :user
end
