# encoding: utf-8
class Conference < ActiveRecord::Base

  # attr_accessor :name, :conferencetype_id, :conferencescope_id, :country_id, :year, :month, :location,
                  :conference_institutions_attributes, :userconferences_attributes

  validates_presence_of :name, :year, :conferencetype_id, :country_id, :conferencescope_id

  validates_numericality_of :id, :conferencescope_id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :conferencetype_id, :country_id,  :greater_than =>0, :only_integer => true

  validates_inclusion_of :isspecialized, :in=> [true, false]

  belongs_to :conferencetype
  belongs_to :country
  belongs_to :conferencescope
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  has_many :conference_institutions
  has_many :institutions, :through => :conference_institutions
  accepts_nested_attributes_for :conference_institutions, :reject_if => proc { |attrs| attrs['institution_id'] == '0' }

  has_many :userconferences
  has_many :users, :through => :userconferences
  accepts_nested_attributes_for :userconferences
  user_association_methods_for :userconferences

  has_many :proceedings

  has_paper_trail

  default_scope -> { order(year: :desc, month: :desc, name: :asc) }

  scope :attendees, -> { joins(:userconferences).where(:userconferences => { :roleinconference_id => 1 }) }
  scope :organizers, -> { joins(:userconferences).where('userconferences.roleinconference_id  != 1') }
  scope :user_id_eq, lambda { |user_id| joins(:userconferences).where(:userconferences => {:user_id => user_id}) }
  scope :user_id_not_eq, lambda { |user_id|  where("conferences.id IN (#{Userconference.select('DISTINCT(conference_id) as conference_id').where(["userconferences.user_id !=  ?", user_id]).to_sql}) AND conferences.id  NOT IN (#{Userconference.select('DISTINCT(conference_id) as conference_id').where(["userconferences.user_id =  ?", user_id]).to_sql})") }

  # search_methods :user_id_eq, :user_id_not_eq

  def to_s
    [name, institution_names, "País: #{country.name}", normalized_type, normalized_scope, date].compact.join(', ')
  end

  def normalized_type
    'Tipo: ' + conferencetype.name unless conferencetype_id.nil?
  end

  def normalized_scope
    'Ámbito: ' + conferencescope.name unless conferencescope_id.nil?
  end

  def institution_names
    institutions.collect {|record| record.name_and_parent_abbrev }.compact.join(', ') if institutions.size > 0
  end

  def conferencescope_name
    conferencescope_id.nil? ? '-' : conferencescope.name
  end

  def conferencetype_name
    conferencetype_id.nil? ? '-' : conferencetype.name
  end

  def country_name
    country_id.nil? ? '-' : country.name
  end
end
