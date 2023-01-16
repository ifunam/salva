class Thesismodality < ActiveRecord::Base
  # attr_accessor :name, :degree_id, :level

  validates_presence_of :name, :degree_id
  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_uniqueness_of :name

  belongs_to :degree
  has_many :theses
  default_scope -> { order(level: :asc) if column_names.include? 'level' }

  def to_s
    "Modalidad: " + name
  end

  def to_s_with_degree_name
    [degree.name, name].join(': ')
  end
end

