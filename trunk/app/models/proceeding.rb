class Proceeding < ActiveRecord::Base
  validates_presence_of :conference_id, :title

  validates_numericality_of :id, :publisher_id,  :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :conference_id, :greater_than =>0 , :only_integer => true

  validates_uniqueness_of :title, :scope => [:conference_id]
  validates_inclusion_of :isrefereed, :in => [true, false]

  belongs_to :conference
  belongs_to :publisher

  has_many :inproceeding
  has_many :user_proceedings

  validates_associated :conference
  validates_associated :publisher

end
