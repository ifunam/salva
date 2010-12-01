class SeminariesController < PublicationController
  defaults :user_role_class => :user_seminaries, :role_class => :roleinseminary, :resource_class_scope => :as_not_attendee
end
