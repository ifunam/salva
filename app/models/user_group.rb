class UserGroup < ActiveRecord::Base
  # attr_accessor :group_id
  validates_numericality_of :id, :user_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :group_id, :greater_than =>0 , :only_integer => true
  validates_presence_of :group_id
  validates_uniqueness_of :group_id, :scope => [:user_id]
  
  belongs_to :user
  belongs_to :group
end
