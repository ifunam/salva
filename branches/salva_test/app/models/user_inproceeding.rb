class UserInproceeding < ActiveRecord::Base
  validates_presence_of :inproceeding_id, :ismainauthor
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :inproceeding_id, :user_id,  :greater_than => 0, :only_integer => true
  validates_inclusion_of :ismainauthor, :in => [true, false]
  validates_uniqueness_of :user_id, :scope => [:inproceeding_id]

  belongs_to :inproceeding
  belongs_to :user

  validates_associated :inproceeding
  validates_associated :user
end
