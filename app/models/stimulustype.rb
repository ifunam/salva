class Stimulustype < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  # attr_accessor :name, :descr, :institution_id


  belongs_to :institution
  has_many :stimuluslevels

  validates_associated :institution

  def institution_name
    institution.name_and_parent_abbrev unless institution_id.nil?
  end
end
