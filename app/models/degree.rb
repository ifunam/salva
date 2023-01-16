class Degree < ActiveRecord::Base
  validates_presence_of :name, :level
  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_uniqueness_of :name
  has_many :careers
  has_many :thesismodalities

  # attr_accessor :name, :level, :careers_attributes, :thesismodalities, :career_ids, :thesismodality_ids

  default_scope -> { order(level: :desc) if column_names.include? 'level' }
  scope :higher, -> { where('id > 1') }
  scope :universitary, -> { where('id = 3 OR id = 5 OR id = 6') }
end
