class SessionPreference < ActiveRecord::Base
  belongs_to :user
  # attr_accessor :search_enabled
end
