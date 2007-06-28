class Inproceeding < ActiveRecord::Base
  validates_presence_of :proceeding_id, :title, :authors
  validates_numericality_of :proceeding_id

  belongs_to :proceeding

  has_many :user_inproceedings
  has_many :users, :through => :user_inproceedings
end
