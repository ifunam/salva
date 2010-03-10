class Roleingroup < ActiveRecord::Base
  validates_presence_of :role_id, :group_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :group_id, :role_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :group_id, :scope => [:role_id]

  belongs_to  :group
  belongs_to :role

  has_many :permissions
end
