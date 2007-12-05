class UserRegularcourse < ActiveRecord::Base
  validates_presence_of :regularcourse_id, :roleinregularcourse_id, :period_id

  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :regularcourse_id, :period_id, :roleinregularcourse_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :hoursxweek, :allow_nil => true, :greater_than => 0 , :only_integer => true

  validates_inclusion_of :hoursxweek, :in => 1..40, :allow_nil => true

  validates_uniqueness_of :user_id, :scope => [:regularcourse_id, :period_id, :roleinregularcourse_id]

  belongs_to :regularcourse
  belongs_to :period
  belongs_to :roleinregularcourse
  belongs_to :user

  validates_associated :regularcourse
  validates_associated :roleinregularcourse
end
