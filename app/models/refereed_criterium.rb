class RefereedCriterium < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  # attr_accessor :name
  has_many :user_refereed_journals
end
