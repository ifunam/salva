class UserArticle < ActiveRecord::Base
  # attr_accessor :article_id, :user_id

  validates_numericality_of :id,  :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :article_id, :user_id, :greater_than => 0, :only_integer => true, :allow_nil => true
  validates_inclusion_of :ismainauthor, :in => [true, false]
  # validates_uniqueness_of :article_id, :scope => [:user_id]
  # attr_accessor :ismainauthor, :user_id, :article_id

  belongs_to :article, :inverse_of => :user_articles
  belongs_to :user, :inverse_of => :user_articles

  scope :default_order, -> { joins(:article).order('articles.year DESC, articles.month DESC, articles.authors ASC, articles.title ASC') }
  scope :published, -> { joins(:article).where(:article => {:articlestatus_id => 3} ) }
  scope :verified, -> { joins(:article).where(:article => {:is_verified => true} ) }
  scope :inprogress, -> { joins(:article).where('articles.articlestatus_id != 3') }
  scope :year, lambda { |year| joins(:article).where('articles.year = ?', year).default_order }
  scope :journal_id, lambda { |id| joins(:article).where('articles.journal_id = ?', id).default_order }
  scope :articlestatus_id, lambda { |id| joins(:article).where('articles.articlestatus_id = ?', id).default_order }
  scope :is_verified_eq, lambda { |s| joins(:article).where('articles.is_verified = ?', s).default_order }
  def self.adscription_id(id)
    res = UserArticle.joins(:user => :user_adscription_records).where(:user => { :user_adscription_records => { :adscription_id => id} }).uniq
  end

  # search_methods :year, :journal_id, :adscription_id, :is_verified_eq, :articlestatus_id

  def as_json(options={})
    { :id=>article.id.to_s, :title=>article.title, :authors=>article.authors,
      :journal=>article.journal.name, :country=>article.journal.country_name,
      :fullname=>user.fullname_or_email, :adscription=>user.adscription_name,
      :year=>article.year, :month=>article.month, :url=>article.url, :user_ids=>article.user_ids
    }
  end
end
