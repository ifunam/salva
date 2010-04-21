Factory.define :user do |u|
  u.crypted_password 'foobar'
  u.password_salt    'foobar'
  u.userstatus {|userstatus| userstatus.association(:userstatus, :name => 'Activo') }      
end

Factory.define :invalid_user do |u|
end

Factory.define :researcher, :parent => :user do |u|
  u.login 'sandoval'
  u.email Forgery(:internet).email_address
  u.association :person, :factory => :researcher_person
  u.association :address, :factory => :researcher_address
end

Factory.define :academic_technician, :parent => :user do |u|
  u.login 'alex'
  u.email Forgery(:internet).email_address
  u.user_incharge {|user| user.association(:user, :login => 'sandoval') }
  u.association :person, :factory => :academic_technician_person
  u.association :address, :factory => :academic_technician_address
end

Factory.define :admin, :parent => :user do |u|
  u.login 'admin'
  u.email Forgery(:internet).email_address
end

Factory.define :staff, :parent => :user do |u|
  u.login 'staff'
  u.email Forgery(:internet).email_address
end

Factory.define :director, :parent => :user do |u|
  u.login 'director'
  u.email Forgery(:internet).email_address
end
