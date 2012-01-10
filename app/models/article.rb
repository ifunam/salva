class Article < ActiveRecord::Base
  validates_presence_of :title, :articlestatus_id, :year, :authors, :journal_id
  validates_numericality_of :id, :journal_id, :only_integer => true, :greater_than => 0, :allow_nil => true
  validates_numericality_of :articlestatus_id, :only_integer => true, :greater_than => 0
  validates_numericality_of :year, :greater_than => (Date.today.year - 100), :less_than_or_equal_to => (Date.today.year + 1), :only_integer => true
  validates_uniqueness_of :title, :scope => [:journal_id, :year]
  normalize_attributes :vol, :num, :pages

  belongs_to :journal
  belongs_to :articlestatus
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  has_many :user_articles
  has_many :users, :through => :user_articles
  accepts_nested_attributes_for :user_articles
  user_association_methods_for :user_articles

  default_scope :order => 'year DESC, month DESC, authors ASC, title ASC, articlestatus_id ASC'

  scope :accepted, where(:articlestatus_id => 1)
  scope :sent, where(:articlestatus_id => 2)
  scope :inprogress, where(:articlestatus_id => 4)
  scope :published, where(:articlestatus_id => 3)
  scope :unpublished, where('articles.articlestatus_id != 3')
  scope :user_id_eq, lambda { |user_id| joins(:user_articles).where(:user_articles => {:user_id => user_id}) }
  scope :user_id_not_eq, lambda { |user_id|  where("articles.id IN (#{UserArticle.select('DISTINCT(article_id) as article_id').where(["user_articles.user_id !=  ?", user_id]).to_sql}) AND articles.id  NOT IN (#{UserArticle.select('DISTINCT(article_id) as article_id').where(["user_articles.user_id =  ?", user_id]).to_sql})") }
  scope :adscription_id_eq, lambda { |adscription_id|  where("articles.id IN (#{UserArticle.select('DISTINCT(article_id) as article_id').joins(:user => :user_adscription).where(["user_articles.user_id = user_adscriptions.user_id  AND user_adscriptions.adscription_id != ?", adscription_id]).to_sql})") }

  search_methods :user_id_eq, :user_id_not_eq, :adscription_id_eq

  def as_text
    [authors, title, journal.name, normalized_date, normalized_vol_and_num, normalized_pages].compact.join(', ').sub(/;,/, ';')
  end

  def normalized_date
    if !vol.to_s.strip.empty? or !num.to_s.strip.empty?
      date.to_s + ";"
    else
      date.to_s 
    end
  end

  def normalized_vol_and_num
    if !vol.to_s.strip.empty?  and !num.to_s.strip.empty?
      "#{vol}(#{num})"
    elsif !vol.to_s.strip.empty?
      "#{vol}"
    elsif !num.to_s.strip.empty?
      "(#{num})"
    end
  end

  def normalized_pages
    pages unless pages.to_s.strip.empty?
  end
end
