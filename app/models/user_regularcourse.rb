class UserRegularcourse < ActiveRecord::Base
  validates_presence_of :roleinregularcourse_id, :period_id

  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :period_id, :roleinregularcourse_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :hoursxweek, :allow_nil => true, :greater_than => 0 , :only_integer => true
  validates_inclusion_of :hoursxweek, :in => 1..40, :allow_nil => true


  belongs_to :regularcourse
  belongs_to :period
  belongs_to :roleinregularcourse
  belongs_to :user
end
