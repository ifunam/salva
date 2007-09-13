class Citizen < ActiveRecord::Base
  validates_presence_of :migratorystatus_id, :citizen_country_id, :citizenmodality_id
  validates_numericality_of :migratorystatus_id, :citizen_country_id, :citizenmodality_id, :only_integer => true
  validates_uniqueness_of :user_id, :citizen_country_id
  validates_numericality_of :id, :allow_nil => true, :only_integer =>true

  belongs_to :migratorystatus
  belongs_to :citizen_country, :class_name => 'Country', :foreign_key => 'citizen_country_id'
  belongs_to :citizenmodality
end
