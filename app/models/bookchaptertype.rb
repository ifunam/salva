class Bookchaptertype < ActiveRecord::Base
  has_many :chapterinbooks
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true

  validates_presence_of :name
  validates_uniqueness_of :name
end
