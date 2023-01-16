class Activity < ActiveRecord::Base
  # attr_accessor :name, :descr, :activitytype_id, :year, :month
  validates_presence_of :name, :activitytype_id, :year
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :activitytype_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name, :scope => [:user_id, :month, :year, :descr]

  belongs_to :activitytype
  belongs_to :user
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  default_scope -> { order(year: :desc, month: :desc, name: :asc) }

  scope :other, -> { where(:activitytype_id => 15) }
  scope :popular_science, -> { joins(:activitytype).where(:activitytype => {:activitygroup_id => 1}) }
  scope :teaching, -> { joins(:activitytype).where(:activitytype => {:activitygroup_id => 3}) }
  scope :technical, -> { joins(:activitytype).where(:activitytype => {:activitygroup_id => 7}) }
  scope :adscription_id, lambda { |id| joins(:user => :user_adscription).where(:user => { :user_adscription => { :adscription_id => id} }) }

  # search_methods :adscription_id
  def to_s
    ["#{name}: #{descr}", "Tipo: #{activitytype.name}", date].compact.join(', ')
  end
end
