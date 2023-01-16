# encoding: utf-8
class UserLanguage < ActiveRecord::Base
  # attr_accessor :language_id, :institution_id, :spoken_languagelevel_id, :written_languagelevel_id

  validates_presence_of :language_id, :spoken_languagelevel_id, :written_languagelevel_id, :institution_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id,:language_id, :spoken_languagelevel_id, :written_languagelevel_id, :institution_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :user_id, :scope => [:language_id, :institution_id]

  belongs_to :institution
  belongs_to :language
  belongs_to :user
  belongs_to :spoken_languagelevel, :class_name => 'Languagelevel', :foreign_key => 'spoken_languagelevel_id'
  belongs_to :written_languagelevel, :class_name => 'Languagelevel', :foreign_key => 'written_languagelevel_id'
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  def to_s
    text = [language.name]
    text.push('Nivel hablado: ' + spoken_languagelevel.name) unless spoken_languagelevel.nil?
    text.push('Nivel escrito: ' + written_languagelevel.name) unless written_languagelevel.nil?
    text.push('Institución donde estudio: ' + institution.name_and_parent_abbrev ) unless institution.nil?
    text.join(', ')
  end
end
