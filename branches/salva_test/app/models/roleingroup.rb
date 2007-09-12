class Roleingroup < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :group_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :role_id, :allow_nil => true, :only_integer => true
  validates_presence_of :role_id, :group_id
  validates_uniqueness_of :group_id, :scope => [:role_id]
  belongs_to  :group
  belongs_to :role
end
