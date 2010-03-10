class UserInproceeding < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_inclusion_of :ismainauthor, :in => [true, false]
  #validates_uniqueness_of :inproceeding_id, :scope => [:user_id]

  belongs_to :inproceeding
  belongs_to :user
end
