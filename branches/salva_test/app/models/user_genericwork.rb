class UserGenericwork  < ActiveRecord::Base
  validates_presence_of :genericwork_id, :userrole_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :genericwork_id, :user_id, :userrole_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :user_id, :scope => [:genericwork_id, :userrole_id]

  belongs_to :genericwork
  belongs_to :userrole
  belongs_to :user

  validates_associated :genericwork
  validates_associated :userrole
  validates_associated :user
end
