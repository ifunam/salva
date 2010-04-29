class User < ActiveRecord::Base
  validates_presence_of :login, :userstatus_id

  belongs_to :userstatus
  belongs_to :user_incharge, :class_name => 'User', :foreign_key => 'user_incharge_id'

  has_one :person
  has_one :address

  def authorname
    if !author_name.to_s.strip.empty?
       author_name
    elsif !person.nil?
      person.shortname
    end
  end

  def fullname_or_login
     person.nil? ? login : person.fullname
  end

  def user_incharge_fullname
    user_incharge.person.fullname if !user_incharge.nil? and !user_incharge.person.nil?
  end

  def avatar(version=:icon)
    if !person.nil? and !person.image.nil?
      person.image.file.url(version.to_sym)
    else
      "/images/avatar_missing_#{version}.png"
    end
  end

  accepts_nested_attributes_for :person, :address
end
