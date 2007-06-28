class Proceeding < ActiveRecord::Base

  validates_presence_of :conference_id, :title
  validates_numericality_of :conference_id

  belongs_to :conference
  belongs_to :publisher

  has_many :inproceedings
  has_many :inproceedings, :through => :inproceedings
end
