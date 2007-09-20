class UserInproceeding < ActiveRecord::Base
  validates_presence_of :inproceeding_id, :ismainauthor
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :inproceeding_id, :allow_nil => true, :only_integer => true
  validates_inclusion_of :ismainauthor, :in => [true, false]

  validates_uniqueness_of :user_id, :scope => [:inproceeding_id]

  belongs_to :inproceeding
end
