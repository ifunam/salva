class Role < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_inclusion_of :has_group_right, :in => [true, false]
  validates_uniqueness_of :name

  has_many :roleingroups

  def to_s
    values = [name, abbrev]
    values << role.name unless role.name.nil?
    values.compact.join(', ')
  end
end

