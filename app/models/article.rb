class Article < ActiveRecord::Base
  validates_presence_of :title, :articlestatus_id, :year, :authors
  validates_numericality_of :id, :journal_id, :only_integer => true, :greater_than => 0, :allow_nil => true
  validates_numericality_of :articlestatus_id, :only_integer => true, :greater_than => 0
  validates_numericality_of :year, :greater_than => (Date.today.year - 100), :less_than_or_equal_to => (Date.today.year + 1), :only_integer => true
  validates_uniqueness_of :title, :scope => [:journal_id, :year]
  normalize_attributes :title, :authors, :volume, :num, :pages

  belongs_to :journal
  belongs_to :articlestatus

  has_many :user_articles
  has_many :users, :through => :user_articles

  default_scope :order => 'year DESC, month DESC, authors ASC, title ASC, articlestatus_id ASC'

  scope :accepted, where(:articlestatus_id => 1)
  scope :sent, where(:articlestatus_id => 2)
  scope :inprogress, where(:articlestatus_id => 3)
  scope :published, where(:articlestatus_id => 4)
  scope :user_id_eq, lambda { |user_id| joins(:user_articles).where(:user_articles => {:user_id => user_id}) }
  scope :user_id_not_eq, lambda { |user_id| joins(:user_articles).where(["user_articles.user_id != ?", user_id]) }

  search_methods :user_id_eq, :user_id_not_eq

  def self.paginated_search(options={})
    search(options[:search]).paginate(:page => options[:page] || 1, :per_page =>  options[:per_page] || 10)
  end

  def as_text
    [authors, title, journal.name, journal_issue, pages].join(', ')
  end

  def journal_issue
    info = year.to_s + ";"
    if vol != nil and num != nil
      info << "#{vol}(#{num})"
    elsif vol != nil
      info << vol
    elsif num != nil
      info << "(#{num})"
    end
    info
  end
end
