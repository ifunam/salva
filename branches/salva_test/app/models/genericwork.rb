class Genericwork < ActiveRecord::Base
  validates_presence_of :authors, :title, :genericworktype_id, :genericworkstatus_id, :year

  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true

  validates_numericality_of :genericworktype_id, :genericworkstatus_id, :year, :only_integer => true
  validates_numericality_of :institution_id, :publisher_id,  :allow_nil => true, :only_integer => true

  validates_uniqueness_of :title, :scope  => [:authors, :genericworktype_id, :genericworkstatus_id, :year]

  belongs_to :genericworktype
  belongs_to :genericworkstatus
  belongs_to :institution
  belongs_to :publisher

  validates_associated :genericworktype
  validates_associated :genericworkstatus
  validates_associated :institution
  validates_associated :publisher

  has_many :user_genericworks
  has_many :users, :through => :user_genericworks
end
