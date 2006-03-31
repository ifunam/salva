class Institution < ActiveRecord::Base
  validates_presence_of :name, :country_id, :institutiontype_id, :institutiontitle_id
  validates_numericality_of :country_id, :institutiontype_id, :institutiontitle_id
  belongs_to :country
  belongs_to :institutiontype
  belongs_to :institutiontitle
  belongs_to :city
  belongs_to :state
  belongs_to :institution
end

