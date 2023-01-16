UserAdscription.blueprint do
  start_date  { Date.today }
  startyear { Forgery(:basic).number }
  adscription_id { Adscription.new.id}
  jobposition_id { Jobposition.new.id }
  user_id { User.new.id }
  # jobposition => it brokes the fixtures
  adscription
  user
end
