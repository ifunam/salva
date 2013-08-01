class UserObserver < ActiveRecord::Observer
  include LDAP::Helpers::UserObserver
  include Aleph::Helpers::UserObserver
  
  def after_create(user)
    create_ldap_user(user) if User.ldap_enabled?
    Notifier.identification_card_request(user.id).deliver
  end

  def after_update(user)
    if user.userstatus_id_changed?
      Notifier.updated_userstatus_to_admin(user.id).deliver
    end

    if !user.password.nil? and User.ldap_enabled?
      update_ldap_user(user)
    end

    if user.has_image? and user.person.image.changed? and User.aleph_enabled?
      create_or_update_aleph_account(user)
    end
  end

  def before_destroy(user)
    destroy_ldap_user(user) if User.ldap_enabled?
    destroy_aleph_user(user) if User.aleph_enabled?
  end
end
