class Inproceeding < ActiveRecord::Base
  validates_presence_of :title, :authors
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :proceeding

  has_many :user_inproceeding
end
