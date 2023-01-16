class Documenttype < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name
  # attr_accessor :name, :start_date, :end_date, :status, :year, :descr

  default_scope -> { order(start_date: :desc, end_date: :desc) }
  scope :annual_reports, -> { where("name LIKE 'Informe anual de actividades%'") }
  scope :annual_plans, -> { where("name LIKE 'Plan de trabajo%'") }
  scope :active, -> { where(:status => true) if column_names.include? 'status' }
  has_many :documents

  def self.year_for_annual_report
    if column_names.include? 'status'
      Documenttype.annual_reports.active.first.nil? ? Date.today.year : Documenttype.annual_reports.active.first.year
    end
  end
end
