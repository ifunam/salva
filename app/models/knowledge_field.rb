class KnowledgeField < ActiveRecord::Base
  # attr_accessor :name, :name_en, :short_name

  validates_presence_of :name
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name

  has_many :knowledge_areas

  default_scope -> { order(name: :asc) }

  def to_s
    name
  end
end
