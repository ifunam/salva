require 'machinist/active_record'
require 'sham'
require 'faker'

User.blueprint do
  login { Faker::Internet.user_name }
  email { Faker::Internet.email }
  password { "foofoo"}
  password_confirmation { "foofoo"}
  userstatus_id { 1 }
  user_incharge_ud { 1 }
  person { Person.make }
  address { Address.make }
end

Person.blueprint do
  firstname     { Faker::Name.first_name }
  lastname1     { Faker::Name.last_name }
  lastname2     { Faker::Name.last_name }
  gender        { true }
  maritalstatus { Maritalstatus.make }
  dateofbirth   { '1977-03-17' }
  country       { Country.make }
  state         { State.make }
  city          { City.make }
end

City.blueprint do
  name  { 'Bochil' }
  state{ State.make }
end

State.blueprint do
  name  { 'Chiapas' }
  country { Country.make }
end
Country.blueprint do 
  name { 'México' }
  citizen { 'Mexicano(a)'}
end


Maritalstatus.blueprint do
  name { 'Soltero' }
end

Address.blueprint do
  addrestype { Addresstype.make }
  location   { Faker::Address.street_address }
  pobox      { Faker::Address.uk_postcode}
  country    { Country.make }
  state      { State.make }
  city       { City.make }
  zipcode    { Faker::Address.zip_code}
  phone      { Faker::PhoneNumber }
  fax        { Faker::PhoneNumber }
  movil      { Faker::PhoneNumber }
  is_postaddress { true }
end

Addresstype.blueprint do
  name { 'Profesional' }
end
