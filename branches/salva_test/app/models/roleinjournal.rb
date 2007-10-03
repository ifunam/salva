class Roleinjournal < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :id,  :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name

  has_many :user_journals
end
