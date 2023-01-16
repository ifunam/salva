class Instadvice < ActiveRecord::Base
  # attr_accessor :title, :instadvicetarget_id, :institution_id, :year, :month

  validates_presence_of :title, :instadvicetarget_id, :year
  validates_numericality_of :user_id, :institution_id, :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :instadvicetarget_id, :year,  :greater_than => 0, :only_integer => true
  validates_inclusion_of :month, :in => 1..12, :allow_nil => true

  belongs_to :institution
  belongs_to :instadvicetarget
  belongs_to :user
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'
  scope :adscription_id, lambda { |id| joins(:user => :user_adscription).where(:user => { :user_adscription => { :adscription_id => id} }) }

  # search_methods :adscription_id

  def to_s
    [target_and_title, institution.name_and_parent_abbrev, date].compact.join(', ')
  end

  def target_and_title
    "#{instadvicetarget.name}: #{title}"
  end
end

