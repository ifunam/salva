Address.blueprint do
  location    { Forgery(:address).street_address }
  pobox       { Forgery(:address).province_abbrev }
  phone       { Forgery(:address).phone }
  fax         { Forgery(:address).phone }
  movil       { Forgery(:address).phone }
  zipcode     { Forgery(:address).zip }
  is_postaddress      { true }
  addresstype_id { Addresstype.make!.id}
  country_id { Country.make!.id}
  user_id { User.make!.id}
  addresstype
  country
  state
  city
  user
end
