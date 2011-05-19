class Inproceeding < ActiveRecord::Base
  validates_presence_of :title, :authors
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :proceeding
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'

  has_many :user_inproceeding
end
