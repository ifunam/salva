class Bookchaptertype < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_presence_of :name, :id
  validates_uniqueness_of :id, :name
  validates_length_of :name, :within => 4..50
  has_many :chapterinbook
end
