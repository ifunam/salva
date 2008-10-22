class Adscription < ActiveRecord::Base
  validates_presence_of :name, :institution_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :institution_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name, :scope => [:institution_id]

  belongs_to :institution

  has_many :user_adscriptions
  has_many :users, :through => :user_adscriptions, :source => :user
  has_many :activated_users, :through => :user_adscriptions, :source => :user, :conditions => 'users.userstatus_id = 2', :uniq => true

  validates_associated :institution
end
