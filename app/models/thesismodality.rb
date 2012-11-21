class Thesismodality < ActiveRecord::Base
  attr_accessible :name, :degree_id, :level

  validates_presence_of :name, :degree_id
  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_uniqueness_of :name

  belongs_to :degree
  has_many :theses
  default_scope :order => 'level ASC'

  def as_text
    [degree.name, name].join(': ')
  end
end

