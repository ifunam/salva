require Rails.root.to_s + '/lib/salva/meta_date_extension'
require Rails.root.to_s + '/lib/salva/meta_user_association'
class Article < ActiveRecord::Base
  include MetaDateExtension::DateMethods
  include MetaUserAssociation
  validates_presence_of :title, :articlestatus_id, :year, :authors, :journal_id
  validates_numericality_of :id, :journal_id, :only_integer => true, :greater_than => 0, :allow_nil => true
  validates_numericality_of :articlestatus_id, :only_integer => true, :greater_than => 0
  validates_numericality_of :year, :greater_than => (Date.today.year - 100), :less_than_or_equal_to => (Date.today.year + 1), :only_integer => true
  # validates_uniqueness_of :title, :scope => [:journal_id, :year]
  normalize_attributes :vol, :num, :pages

  belongs_to :journal, :inverse_of => :articles
  belongs_to :articlestatus, :inverse_of => :articles
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  has_many :user_articles, :inverse_of => :article
  has_many :users, :through => :user_articles, :inverse_of => :articles
  user_association_methods_for :user_articles

  mount_uploader :document, DocumentUploader
  accepts_nested_attributes_for :user_articles, :allow_destroy => true
  attr_accessible :authors, :title, :journal_id, :year, :month, :vol, :num, :pages, :doi, :url, :other,
                  :articlestatus_id, :is_verified, :user_articles_id, :user_articles_attributes, :user_ids, :document, :document_cache, :remove_document

  has_paper_trail

  default_scope :order => 'year DESC, month DESC, authors ASC, title ASC, articlestatus_id ASC'

  scope :accepted, where(:articlestatus_id => 1)
  scope :sent, where(:articlestatus_id => 2)
  scope :inprogress, where(:articlestatus_id => 4)
  scope :published, where(:articlestatus_id => 3)
  scope :unpublished, where('articles.articlestatus_id != 3')
  scope :user_id_eq, lambda { |user_id| joins(:user_articles).where(:user_articles => {:user_id => user_id}) }

  scope :user_id_not_eq, lambda { |user_id|
    articles_without_user_sql = UserArticle.select('DISTINCT(article_id) as article_id').where(["user_articles.user_id !=  ?", user_id]).to_sql
    articles_with_user_sql = UserArticle.select('DISTINCT(article_id) as article_id').where(["user_articles.user_id =  ?", user_id]).to_sql
    sql = "articles.id IN (#{articles_without_user_sql}) AND articles.id NOT IN (#{articles_with_user_sql})"
    where(sql)
  }

  scope :adscription_id_eq, lambda { |adscription_id| 
    article_in_adscription_sql = UserArticle.select('DISTINCT(article_id) as article_id').joins(:user => :user_adscription).where(["user_articles.user_id = user_adscriptions.user_id  AND user_adscriptions.adscription_id != ?", adscription_id]).to_sql
    sql = "articles.id IN (#{article_in_adscription_sql})"
    where(sql)
  }
  scope :recent, :limit => 50

  search_methods :user_id_eq, :user_id_not_eq, :adscription_id_eq

  def to_s
    array = [authors, title, journal.name, normalized_date, normalized_vol_and_num, normalized_pages]
    if articlestatus_id != 3
      array.push("Status: #{articlestatus.name}")
    end
    array.compact.join(', ').sub(/;,/, ';')
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
