class Genericworktype < ActiveRecord::Base
  validates_presence_of :name, :genericworkgroup_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :genericworkgroup_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name, :scope => [:genericworkgroup_id]

  belongs_to :genericworkgroup

  default_scope :order => 'name ASC, genericworkgroup_id ASC'
  scope :popular_science, where(:genericworkgroup_id => 1)
  scope :outreach_works, where(:genericworkgroup_id => 6)

  has_many :genericworks
end
