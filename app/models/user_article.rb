class UserArticle < ActiveRecord::Base
  attr_accessible :article_id, :user_id

  validates_numericality_of :id,  :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :article_id, :user_id, :greater_than => 0, :only_integer => true, :allow_nil => true
  validates_inclusion_of :ismainauthor, :in => [true, false]
  # validates_uniqueness_of :article_id, :scope => [:user_id]
  attr_accessible :ismainauthor, :user_id, :article_id

  belongs_to :article, :inverse_of => :user_articles
  belongs_to :user, :inverse_of => :user_articles

  scope :default_order, joins(:article).order('articles.year DESC, articles.month DESC, articles.authors ASC, articles.title ASC')
  scope :published, joins(:article).where(:article => {:articlestatus_id => 3} )
  scope :inprogress, joins(:article).where('articles.articlestatus_id != 3')
  scope :year, lambda { |year| joins(:article).where('articles.year = ?', year).default_order }
  scope :journal_id, lambda { |id| joins(:article).where('articles.journal_id = ?', id).default_order }
  scope :articlestatus_id, lambda { |id| joins(:article).where('articles.articlestatus_id = ?', id).default_order }
  scope :is_verified_eq, lambda { |s| joins(:article).where('articles.is_verified = ?', s).default_order }
  scope :adscription_id, lambda { |id| joins(:user => :user_adscription).where(:user => { :user_adscription => { :adscription_id => id} }).default_order }

  search_methods :year, :journal_id, :adscription_id, :is_verified_eq, :articlestatus_id
end
