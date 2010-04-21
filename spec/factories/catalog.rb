Factory.define :userstatus do |us|
  us.name 'Activo'
end

Factory.define :addresstype do |at|
  at.name 'Profesional'
end

Factory.define :city do |c|
  c.name  'Bochil'
  c.state { |state| state.association(:state, :name => 'Chiapas') } 
end

Factory.define :state do |s|
  s.name 'Chiapas'
  s.country { |country| country.association(:country, :code => '484') }
end

Factory.define :country do |c|
  c.name 'México'
  c.citizen 'Mexicano(a)'
  c.code  484
end

Factory.define :maritalstatus do |ms|
  ms.name 'Soltero'
end
