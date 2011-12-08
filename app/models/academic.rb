class User < ActiveRecord::Base
  set_table_name :users

  extend LDAP::Helpers::UserModel
  extend Aleph::Helpers::UserModel

  if ldap_enabled?
    devise :ldap_authenticatable, :timeoutable, :lockable
  else
    devise :database_authenticatable, :encryptable, :timeoutable, :lockable
  end
end