# encoding: utf-8
class Address < ActiveRecord::Base
  attr_accessible :addresstype_id, :location, :pobox, :country_id, :city_id,
                  :state_id, :zipcode, :phone, :is_postaddress

  validates_presence_of :country_id,  :location, :addresstype_id
  validates_numericality_of :id, :state_id, :city_id, :user_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :addresstype_id, :country_id, :greater_than => 0, :only_integer => true
  validates_inclusion_of :is_postaddress, :in=> [true, false]
  validates_uniqueness_of :addresstype_id, :scope => [:user_id]

  belongs_to :country
  belongs_to :addresstype
  belongs_to :city
  belongs_to :state
  belongs_to :user

  def as_text
    [location.gsub(/\n/,''), normalized_zipcode, normalized_city, country.name].compact.join(', ')
  end

  def normalized_zipcode
    'C.P. ' + zipcode.to_s unless zipcode.to_s.strip.empty?
  end

  def normalized_city
    city.name unless city_id.nil?
  end

  def postal_address_as_text
    if pobox.to_s.strip.empty?
      'Instituto de Neurobiología, C.P. 76130'
    else
      pobox
    end
  end

end
