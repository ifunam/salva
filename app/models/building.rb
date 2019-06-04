class Building < ActiveRecord::Base
  attr_accessible :id, :name, :created_at, :updated_at
  validates_numericality_of :id
  validates_presence_of :name
  has_many :addresses

  default_scope order(:id)
end
