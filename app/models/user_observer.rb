class UserObserver < ActiveRecord::Observer
  include LDAP::Helpers::UserObserver
  include Aleph::Helpers::UserObserver
  
  def after_create(user)
    jp = Jobposition.most_recent_jp(user.id)
    u_id = user.id
    a_id = jp.user_adscription.adscription_id if user.has_adscription?
    j_id = jp.id
    year = Time.now.year
    create_ldap_user(user) if User.ldap_enabled?
    UserAdscriptionRecord.create(:user_id=>u_id,:adscription_id=>a_id,:jobposition_id=>j_id,:year=>year)
    Notifier.identification_card_request(user.id).deliver
  end

  def after_update(user)
    if user.has_adscription? then
      year = Time.now.year
      u_id = user.id
      uar = UserAdscriptionRecord.where(:user_id=>u_id, :year=>year).first
      j_id = uar.jobposition_id
      a_id = uar.adscription_id
      uar.update_attributes(:adscription_id=>a_id,:jobposition_id=>j_id)
      ua = UserAdscription.where(:user_id=>u_id).last
      ua.update_attributes(:adscription_id=>a_id)
    end
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
