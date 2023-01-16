class Stimuluslevel < ActiveRecord::Base
  # attr_accessor :name, :stimulustype_id, :stimulustype_attributes

  validates_presence_of :name, :stimulustype_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  belongs_to :stimulustype
  #has_many :user_stimuli
  default_scope -> { includes(:stimulustype).order(stimulustypes: { name: :asc }, stimuluslevels: { name: :asc }) }
  accepts_nested_attributes_for :stimulustype

  def name_and_type
    [stimulustype.name, name, stimulustype.institution_name].compact.join(' ')
  end
end
