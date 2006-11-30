class Newspaper < ActiveRecord::Base
  validates_presence_of :name, :country_id
  validates_numericality_of :country_id
  belongs_to :country
  has_many :newspaperarticle
end
