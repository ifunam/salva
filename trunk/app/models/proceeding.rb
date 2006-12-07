class Proceeding < ActiveRecord::Base
  validates_presence_of :conference_id
  validates_numericality_of :conference_id
  belongs_to :conference
  belongs_to :publisher
  belongs_to :volume
  has_many :inproceeding
end
