class UserLanguage < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :language_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :spoken_languagelevel_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :written_languagelevel_id, :allow_nil => true, :only_integer => true

  validates_presence_of :language_id, :spoken_languagelevel_id, :written_languagelevel_id, :institution_id

  belongs_to :language
  belongs_to :user
  belongs_to :spoken_languagelevel, :class_name => 'Languagelevel', :foreign_key => 'spoken_languagelevel_id'
  belongs_to :written_languagelevel, :class_name => 'Languagelevel', :foreign_key => 'written_languagelevel_id'
  belongs_to :institution
end
