class Courseduration < ActiveRecord::Base
validates_presence_of :name, :days
end
