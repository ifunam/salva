class Stimuluslevel < ActiveRecord::Base
  attr_accessible :name, :stimulustype_id

  validates_presence_of :name, :stimulustype_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  belongs_to :stimulustype
  has_many :user_stimuluses
  default_scope :order => 'stimulustypes.name ASC, stimuluslevels.name ASC', :joins => :stimulustype

  def name_and_type
    [stimulustype.name, name, stimulustype.institution_name].compact.join(' ')
  end
end
