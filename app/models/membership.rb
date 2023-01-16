# encoding: utf-8
class Membership < ActiveRecord::Base
  # attr_accessor :institution_id, :startyear, :endyear

  validates_presence_of :institution_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of  :user_id, :greater_than => 0, :only_integer => true

  belongs_to :institution
  belongs_to :user
  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'

  default_scope -> { order(endyear: :desc, startyear: :desc) }

  def to_s
    start_year = 'Año de inicio ' + startyear.to_s
    end_year = endyear.nil? ? nil : ('Año de término: ' + endyear.to_s)
    [institution.name_and_parent_abbrev, start_year, end_year].compact.join(', ')
  end
end
