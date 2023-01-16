class Roleinseminary < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_uniqueness_of :name

  default_scope -> { order(name: :asc) }

  scope :not_attendee, -> { where('id != 1') }

  has_many :user_seminaries
end
