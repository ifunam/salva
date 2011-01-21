class Career < ActiveRecord::Base
  validates_presence_of :name, :degree_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :degree_id, :greater_than => 0, :only_integer => true

  belongs_to :degree
  belongs_to :institution
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  has_many :indivadvices
  has_many :educations

  def as_text
      ["Carrera: #{name}, Grado: #{degree.name}", institution.as_text].join(', ')
  end
end
