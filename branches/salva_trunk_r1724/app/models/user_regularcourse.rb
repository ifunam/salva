class UserRegularcourse < ActiveRecord::Base
  validates_presence_of :regularcourse_id, :roleinregularcourse_id, :period_id
  validates_numericality_of :regularcourse_id, :period_id, :roleinregularcourse_id, :only_integer => true
  validates_numericality_of :hoursxweek, :allow_nil => true, :only_integer => true
  validates_inclusion_of :hoursxweek, :in => 1..40, :allow_nil => true 
  belongs_to :regularcourse
  belongs_to :period
  belongs_to :roleinregularcourse
end
