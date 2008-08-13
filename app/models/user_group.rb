class UserGroup < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :group_id, :greater_than =>0 , :only_integer => true
  validates_presence_of :group_id
  validates_uniqueness_of :group_id, :scope => [:user_id]
  belongs_to :user
  belongs_to :group
end
