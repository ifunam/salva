class UserRegularcourse < ActiveRecord::Base
  validates_presence_of     :period_id
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :period_id, :roleinregularcourse_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :hoursxweek, :allow_nil => true, :greater_than => 0 , :only_integer => true
  validates_inclusion_of    :hoursxweek, :in => 1..40, :allow_nil => true

  belongs_to :regularcourse
  belongs_to :period
  belongs_to :roleinregularcourse
  belongs_to :user

  def as_text
    ["#{roleinregularcourse.name}: #{regularcourse.as_text}", "Horas por semana: #{hoursxweek}", "Periodo escolar: #{period.title}"].join(', ')
  end

  def role_and_period
    ["Rol: #{roleinregularcourse.name}", "Periodo escolar: #{period.title}"].join(', ')
  end
end
