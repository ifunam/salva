class UserThesis < ActiveRecord::Base
  validates_presence_of :thesis_id, :roleinthesis_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :thesis_id, :user_id, :roleinthesis_id, :greater_than => 0, :only_integer => true

  belongs_to :user
  belongs_to :thesis
  belongs_to :roleinthesis

  validates_associated :user
  validates_associated :thesis
  validates_associated :roleinthesis
end

