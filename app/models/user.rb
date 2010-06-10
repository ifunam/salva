class User < ActiveRecord::Base
  validates_presence_of :login, :userstatus_id

  belongs_to :userstatus
  belongs_to :user_incharge, :class_name => 'User', :foreign_key => 'user_incharge_id'

  has_one :person
  
  scope :activated, where(:userstatus_id => 2)
  scope :disabled, where('userstatus_id != 2')
  
  scope :find_all_by_fullname_asc, includes(:person).order('people.lastname1 ASC, people.lastname2 ASC, people.firstname ASC')

  # These relationships will be changed to has_many
  has_one :address
  has_one :jobposition
  has_one :jobposition_log
  has_one :user_group

  accepts_nested_attributes_for :person, :address, :jobposition, :jobposition_log, :user_group

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

  def fullname_or_email
     person.nil? ? email : person.fullname
  end

  def user_incharge_fullname
    user_incharge.nil? ? '' : user_incharge.fullname_or_login
  end

  def avatar(version=:icon)
    if !person.nil? and !person.image.nil?
      person.image.file.url(version.to_sym)
    else
      "/images/avatar_missing_#{version}.png"
    end
  end

end
