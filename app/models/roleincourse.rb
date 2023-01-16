class Roleincourse < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name

  has_many :user_courses

  scope :instructors, -> { where('id != 2') }
end
