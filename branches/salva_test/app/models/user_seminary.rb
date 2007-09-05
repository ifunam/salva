class UserSeminary < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :seminary_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :roleinseminary_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true
  validates_presence_of :seminary_id, :roleinseminary_id
  validates_uniqueness_of :user_id, :scope => [:seminary_id, :roleinseminary_id]

  belongs_to :seminary
  belongs_to :roleinseminary
end
