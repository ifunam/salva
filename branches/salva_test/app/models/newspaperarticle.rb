class Newspaperarticle < ActiveRecord::Base
  validates_presence_of :title, :authors, :newspaper_id, :newsdate
  validates_numericality_of :newspaper_id
  belongs_to :newspaper
  has_many :user_newspaperarticles
end
