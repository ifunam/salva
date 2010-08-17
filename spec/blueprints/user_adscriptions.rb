UserAdscription.blueprint do
  startyear { Forgery(:basic).number }
  adscription_id { Adscription.make!.id}
  jobposition_id { Jobposition.make!.id }
  user_id { User.make!.id }
  # jobposition => it brokes the fixtures
  adscription
  user
end
