User.blueprint do
  text_plain_password = Forgery(:basic).password
  login { Forgery::Internet.user_name }
  password { text_plain_password }
  password_confirmation { text_plain_password }
  email { Forgery::Internet.email_address }
  userstatus_id { Userstatus.make!.id }
  userstatus
end
