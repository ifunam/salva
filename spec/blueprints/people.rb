Person.blueprint do
  user_id =  User.make!.id
  id            { user_id }
  firstname     { Forgery(:name).first_name }
  lastname1     { Forgery(:name).last_name }
  lastname2     { Forgery(:name).last_name }
  gender        { true }
  dateofbirth   { '1977-03-17' }
  country_id    { Country.make!.id }
  user_id       { user_id }
  maritalstatus
  country
  state
  city
  user
  image
end
