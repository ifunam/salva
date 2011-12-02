class Documenttype < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name

  default_scope :order => 'start_date DESC, end_date DESC'
  scope :annual_reports, where("name LIKE 'Informe anual de actividades%'")
  scope :annual_plans, where("name LIKE 'Plan de trabajo%'")
  scope :active, where(:status => true)
  has_many :documents
end
