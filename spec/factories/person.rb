Factory.define :person do |p|
  p.firstname   Forgery(:name).first_name
  p.lastname1   Forgery(:name).last_name
  p.lastname2   Forgery(:name).last_name
  p.gender      true
  p.maritalstatus { |maritalstatus| maritalstatus.association(:maritalstatus, :name => 'Soltero') }
  p.dateofbirth   '1977-03-17'
  p.country       { |country| country.association(:country, :code => 484) }
  p.state         { |state| state.association(:state, :name => 'Chiapas') }
  p.city          { |city| city.association(:city, :name => 'Bochil') }
end

Factory.define :researcher_person, :class => Person, :parent => :person do |a|
  a.user { |u| u.association(:researcher) }
end

Factory.define :academic_technician_person, :class => Person, :parent => :person do |a|
  a.user { |u| u.association(:academic_technician) }
end

Factory.define :invalid_person, :class => Person do |p|
end
