class Citizen < ActiveRecord::Base
  validates_presence_of :migratorystatus_id, :citizen_country_id, :citizenmodality_id

  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :migratorystatus_id, :citizen_country_id, :citizenmodality_id, :greater_than =>0, :only_integer => true



  validates_uniqueness_of :user_id, :scope => [:citizen_country_id]



  belongs_to :migratorystatus
  belongs_to :citizen_country, :class_name => 'Country', :foreign_key => 'citizen_country_id'
  belongs_to :citizenmodality

  validates_associated :migratorystatus
  validates_associated :citizen_country
  validates_associated :citizenmodality
end
