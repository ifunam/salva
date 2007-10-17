class UserLanguage < ActiveRecord::Base
  validates_presence_of :language_id, :spoken_languagelevel_id, :written_languagelevel_id, :institution_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :language_id, :spoken_languagelevel_id, :written_languagelevel_id, :institution_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :user_id, :scope => [:language_id, :institution_id]

  belongs_to :institution
  belongs_to :language
  belongs_to :user
  belongs_to :spoken_languagelevel, :class_name => 'Languagelevel', :foreign_key => 'spoken_languagelevel_id'
  belongs_to :written_languagelevel, :class_name => 'Languagelevel', :foreign_key => 'written_languagelevel_id'

  validates_associated :institution
  validates_associated :language
  validates_associated :user
  validates_associated :languagelevel
  end
