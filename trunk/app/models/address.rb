class Address < ActiveRecord::Base
  validates_presence_of :country_id, :location
  validates_numericality_of :country_id, :addresstype_id
  validates_inclusion_of :is_postaddress, :in=> [true, false]
  belongs_to :country
  belongs_to :addresstype
  belongs_to :city
  belongs_to :state

  def as_text
    info = [ location ]
    info << 'Apartado postal: ' + pobox if !pobox.empty? and pobox != nil
    %w(country state city).each { |f| info << self.send(f.to_sym).name if self.send(f.to_sym) != nil }
    info << 'Código postal: ' + zipcode.to_s if zipcode != nil
    info.join(', ')
  end

end
