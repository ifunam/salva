class Institutiontype < ActiveRecord::Base
  # attr_accessor :name
  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :institutions

  default_scope -> { order(name: :desc) }

end
