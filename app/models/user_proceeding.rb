class UserProceeding < ActiveRecord::Base
  # attr_accessor :roleproceeding_id, :user_id, :proceeding_id
  validates_presence_of :roleproceeding_id
  validates_numericality_of :id, :user_id, :proceeding_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :roleproceeding_id, :greater_than => 0, :only_integer => true

  belongs_to :user
  belongs_to :proceeding
  belongs_to :roleproceeding

  scope :year_eq, lambda { |year| joins(:proceeding).where('proceedings.year = ?', year) }
  scope :conferencescope_id, lambda { |id| joins(:proceeding => :conference).where('conferences.conferencescope_id = ?', id) }
  scope :adscription_id, lambda { |id| joins(:user => :user_adscription).where(:user => { :user_adscription => { :adscription_id => id} }) }

  # search_methods :year_eq, :conferencescope_id, :adscription_id

  def author_with_role
    "#{user.author_name} (#{roleproceeding.name})"
  end
end
