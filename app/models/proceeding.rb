class Proceeding < ActiveRecord::Base
  validates_presence_of :title
  validates_numericality_of :id, :publisher_id,  :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_inclusion_of :isrefereed, :in => [true, false]

  belongs_to :conference
  belongs_to :publisher

  has_many :inproceeding
  has_many :user_proceedings
end
