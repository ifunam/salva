class Proceeding < ActiveRecord::Base
  validates_presence_of :conference_id, :title, :isrefereed
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :conference_id, :allow_nil => true, :only_integer => true

  validates_uniqueness_of :title, :scope => [:conference_id]
  validates_inclusion_of :isrefereed, :in => [true, false]

  belongs_to :conference
  belongs_to :publisher
  has_many :inproceeding
end
