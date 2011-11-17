class Career < ActiveRecord::Base
  validates_presence_of :name, :degree_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :degree_id, :greater_than => 0, :only_integer => true

  belongs_to :degree
  belongs_to :institution
  accepts_nested_attributes_for :institution
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  has_many :indivadvices
  has_many :educations
  has_many :tutorial_committees
  has_many :theses
  has_many :academicprograms
  has_many :institutioncareers

  def as_text
    ["Carrera: #{name}, Grado: #{degree.name}", institution.name_and_parent_name].join(', ')
  end
end
