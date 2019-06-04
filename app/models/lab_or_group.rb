class LabOrGroup < ActiveRecord::Base
  attr_accessible :name, :name_en, :url, :short_name

  validates_presence_of :name
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name

  has_many :user_lab_or_groups

  default_scope order('id ASC')

  def to_s
    name
  end
end
