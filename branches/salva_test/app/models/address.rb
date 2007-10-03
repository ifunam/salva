class Address < ActiveRecord::Base
  validates_presence_of :user_id, :country_id, :location, :addresstype_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of  :user_id, :addresstype_id, :country_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :user_id, :scope => [:addresstype_id]
  validates_inclusion_of :is_postaddress, :in=> [true, false]

  belongs_to :country
  belongs_to :addresstype
  belongs_to :city
  belongs_to :state
  belongs_to :user

  validates_associated :country
  validates_associated :addresstype
  validates_associated :city
  validates_associated :state
  validates_associated :user

  def as_text
    info = [ 'Ubicación: ' + self.location ]
    info << 'Apartado postal: ' + self.pobox if !self.pobox.empty? and self.pobox != nil
    %w(country state city).each { |f| info << self.send(f.to_sym).name if self.send(f.to_sym) != nil }
    info << 'Código postal: ' + self.zipcode.to_s if self.zipcode != nil
    info.join(', ')
  end
end
