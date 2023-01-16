# encoding: utf-8
class Address < ActiveRecord::Base
  # attr_accessor :addresstype_id, :location, :pobox, :country_id, :city_id,
  #                 :state_id, :zipcode, :phone, :is_postaddress, :phone_extension, :fax, :building_id

  validates_presence_of :country_id,  :location, :addresstype_id, :building_id
  validates_numericality_of :id, :state_id, :city_id, :user_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :addresstype_id, :country_id, :building_id, :greater_than => 0, :only_integer => true
  validates_inclusion_of :is_postaddress, :in=> [true, false]
  validates_uniqueness_of :addresstype_id, :scope => [:user_id]

  belongs_to :building
  belongs_to :country
  belongs_to :addresstype
  belongs_to :city
  belongs_to :state
  belongs_to :user

  def to_s
    [normalized_building, location.gsub(/\r/,'').strip.gsub(/\n/,', '), my_institution_name, additional_info, normalized_zipcode, normalized_city, country.name].compact.join(', ')
  end

  def normalized_building
    'Edificio : ' + building.name unless building_id.nil?
  end

  def normalized_zipcode
    'C.P. ' + zipcode.to_s unless zipcode.to_s.strip.empty?
  end

  def normalized_city
    city.name unless city_id.nil?
  end

  # TODO: We should get this information from some configuration file
  def my_institution_name
    Salva::SiteConfig.institution('name').to_s
  end

  def additional_info
    Salva::SiteConfig.institution('address').to_s
  end

  def postal_address_to_s
    Salva::SiteConfig.institution('pobox').to_s
  end
end
