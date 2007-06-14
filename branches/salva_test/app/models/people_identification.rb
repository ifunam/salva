class PeopleIdentification < ActiveRecord::Base
  validates_presence_of :identification_id, :descr
  validates_numericality_of :identification_id
  belongs_to :identification
end
