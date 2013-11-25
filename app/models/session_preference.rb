class SessionPreference < ActiveRecord::Base
  belongs_to :user
  attr_accessible :search_enabled
end
