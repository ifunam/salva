class UserRegularcourse < ActiveRecord::Base
  attr_accessible :user_id, :period_id, :roleinregularcourse_id, :hoursxweek, :regularcourse_id, :registered_by_id
  validates_presence_of     :period_id
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :period_id, :roleinregularcourse_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :hoursxweek, :allow_nil => true, :greater_than => 0 , :only_integer => true
  validates_inclusion_of    :hoursxweek, :in => 1..40, :allow_nil => true
  validates_uniqueness_of :regularcourse_id, :scope => [:period_id, :user_id]

  belongs_to :regularcourse
  belongs_to :period
  belongs_to :roleinregularcourse
  belongs_to :user
  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'

  def as_text
    ["#{roleinregularcourse.name}: #{regularcourse.as_text}", "Horas por semana: #{hoursxweek}", "Periodo escolar: #{period.title}"].join(', ')
  end

  def role_and_period_and_hours
    ["Rol: #{roleinregularcourse.name}", "Periodo: #{period.title}", "Horas x semana: #{hoursxweek}"].join(', ')
  end

  def teacher_with_role
    [user.author_name, "(#{role_and_period_and_hours})"].join(' ')
  end
end
