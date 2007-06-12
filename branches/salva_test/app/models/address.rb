class Address < ActiveRecord::Base


  validates_presence_of :country_id, :location
  validates_numericality_of :country_id, :addresstype_id
  validates_inclusion_of :is_postaddress, :in=> [true, false]
  validates_uniqueness_of :addresstype_id
  belongs_to :country
  belongs_to :addresstype
  belongs_to :city
  belongs_to :state
  attr_accessor :name, :code

  def as_text
    info = [ 'Ubicación: ' + self.location ]
    info << 'Apartado postal: ' + self.pobox if !self.pobox.empty? and self.pobox != nil
    %w(country state city).each { |f| info << self.send(f.to_sym).name if self.send(f.to_sym) != nil }
    info << 'Código postal: ' + self.zipcode.to_s if self.zipcode != nil
    info.join(', ')
  end

end
