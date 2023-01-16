class Publisher < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name

  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  has_many :journals, :inverse_of => :publisher
  has_many :genericworks
  has_many :bookedition_publishers
  has_many :proceedings
  default_scope -> { order(name: :asc) }
  # attr_accessor :name, :descr, :url, :is_verified
end
