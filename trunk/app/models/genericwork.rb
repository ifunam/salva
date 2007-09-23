class Genericwork < ActiveRecord::Base
  has_many :user_genericworks
  has_many :users, :through => :user_genericworks

  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :genericworktype_id, :genericworkstatus_id

  validates_presence_of :authors, :title, :genericworktype_id, :genericworkstatus_id, :year

  belongs_to :genericworktype
  belongs_to :genericworkstatus
  belongs_to :institution
  belongs_to :publisher

end
