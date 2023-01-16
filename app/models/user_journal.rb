class UserJournal < ActiveRecord::Base
  # attr_accessor :journal_id, :roleinjournal_id, :startyear, :startmonth, :endyear, :endmonth

  validates_presence_of :journal_id, :roleinjournal_id, :startyear

  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :journal_id, :roleinjournal_id, :startyear, :greater_than => 0, :only_integer => true
  validates_numericality_of :startmonth, :endyear, :endmonth, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :user
  belongs_to :journal
  belongs_to :roleinjournal
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  default_scope -> { order(endyear: :desc, endmonth: :desc, startyear: :desc, startmonth: :desc) }
  scope :adscription_id, lambda { |id| joins(:user => :user_adscription).where(:user => { :user_adscription => { :adscription_id => id} }) }

  # search_methods :adscription_id

  def to_s
    [journal_name, "#{roleinjournal.name}: #{user.author_name}", start_date, end_date].compact.join(', ')
  end

  def journal_name
    (journal_id.nil? or journal.nil?) ? '-' : journal.name
  end

  def journal_country
    (journal_id.nil? or journal.nil?) ? '-' : journal.country_name
  end
end
