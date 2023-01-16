class UserAdscriptionRecord < ActiveRecord::Base
  # attr_accessor :user_id, :adscription_id, :jobposition_id, :year
  belongs_to :user
  belongs_to :adscription
  belongs_to :jobposition

  def self.current_adscription_users(adscription_id)
    where(:adscription_id=>adscription_id,:year=>Time.now.year)
  end
end
