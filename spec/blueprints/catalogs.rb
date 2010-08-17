Userstatus.blueprint do
    name { "Activo #{sn}" }
end

Maritalstatus.blueprint do 
  name { Forgery::LoremIpsum.word + " #{sn}" }
end

Addresstype.blueprint do 
  name { "Profesional #{sn}" }
end

Country.blueprint do
  id = Country.last.nil? ? Forgery(:basic).number : (Country.last.id + 1)
  id {  id }
  code {  id }
  name { Forgery::Address.country  + " #{sn}" }
  citizen { Forgery::Address.country + " #{sn}" }
end

State.blueprint do 
  name { Forgery::Address.state + " #{sn}" }
end

City.blueprint do 
  name { Forgery::Address.city + " #{sn}"}
end

Group.blueprint do 
  name { Forgery(:basic).name + " #{sn}" }
end

Institutiontitle.blueprint do
    name { Forgery(:basic).name + " #{sn}" }
end

Institutiontype.blueprint do
    name { Forgery(:basic).name + " #{sn}" }
end

Institution.blueprint do
   name { Forgery(:basic).name + " #{sn}" }
   institutiontitle_id { Institutiontitle.make!.id }
   institutiontype_id  { Institutiontype.make!.id }  
   country_id  { Country.make!.id }  
   institutiontitle
   institutiontype
   country
end

Contracttype.blueprint do
    name { Forgery(:basic).name + " #{sn}" }
end

Jobpositioncategory.blueprint do
  jobpositiontype_id { Jobpositiontype.make!.id }
  roleinjobposition_id { Roleinjobposition.make!.id }
  jobpositiontype
  jobpositionlevel
  roleinjobposition
end

Jobpositiontype.blueprint do
    name { Forgery(:basic).name + " #{sn}" }
end

Jobpositionlevel.blueprint do
    name { Forgery(:basic).name + " #{sn}" }
end

Roleinjobposition.blueprint do
    name { Forgery(:basic).name + " #{sn}" }
end

Adscription.blueprint do
    name { Forgery(:basic).name + " #{sn}" }
    institution_id { Institution.make!.id }
    institution
end

