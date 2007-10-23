class UserCite < ActiveRecord::Base
  validates_presence_of :author_name, :total
  validates_numericality_of :total, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :user_id

  belongs_to :user
  validates_associated :user
end
