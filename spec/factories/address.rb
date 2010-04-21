Factory.define :address do |a|
  a.addresstype { |addresstype| addresstype.association(:addresstype, :name => 'Profesional') }
  a.location    Forgery(:address).street_address
  a.pobox      Forgery(:address).province_abbrev
  a.country     { |country| country.association(:country, :code => 484) }
  a.state       { |state| state.association(:state, :name => 'Chiapas') }
  a.city        { |city| city.association(:city, :name => 'Bochil') }
  a.phone       Forgery(:address).phone
  a.fax         Forgery(:address).phone
  a.movil       Forgery(:address).phone
  a.zipcode     Forgery(:address).zip
  a.is_postaddress      true
end

Factory.define :researcher_address, :class => Address, :parent => :address do |a|
  a.user { |u| u.association(:researcher) }
end

Factory.define :academic_technician_address, :class => Address, :parent => :address do |a|
  a.user { |u| u.association(:academic_technician) }
end

Factory.define :invalid_address, :class => Address do |u|
end
