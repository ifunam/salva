class Institution < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :institutiontitle_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :institutiontype_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :country_id, :allow_nil => true, :only_integer => true

  validates_presence_of :name, :institutiontitle_id, :institutiontype_id, :country_id

  belongs_to :country
  belongs_to :institutiontype
  belongs_to :institutiontitle
  belongs_to :city
  belongs_to :state
  belongs_to :institution

  has_many :prizes
  has_many :grants
  has_many :acadvisits
  has_many :courses
  has_many :schoolarships

  def as_text
    values = [name, abbrev]
    values << institution.name unless institution.name.nil?
    values.compact.join(', ')
  end
end

