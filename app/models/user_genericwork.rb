class UserGenericwork  < ActiveRecord::Base
  validates_presence_of :userrole_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :userrole_id, :greater_than => 0, :only_integer => true

  belongs_to :genericwork
  belongs_to :userrole
  belongs_to :user

  def author_with_role
    [user.author_name, "(#{userrole.name})"].join(' ')
  end
end
