require Rails.root.to_s + '/lib/salva/meta_date_extension'
require Rails.root.to_s + '/lib/salva/meta_user_association'
class Article < ActiveRecord::Base
  include MetaDateExtension::DateMethods
  include Salva::MetaUserAssociation
  validates_presence_of :title, :articlestatus_id, :year, :authors, :journal_id
  validates_numericality_of :id, :journal_id, :only_integer => true, :greater_than => 0, :allow_nil => true
  validates_numericality_of :articlestatus_id, :only_integer => true, :greater_than => 0
  validates_numericality_of :year, :greater_than => (Date.today.year - 100), :less_than_or_equal_to => (Date.today.year + 1), :only_integer => true
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
  # attr_accessor :authors, :title, :journal_id, :year, :month, :vol, :num, :pages, :doi, :url, :other,
                  :articlestatus_id, :is_verified, :user_articles_id, :user_articles_attributes, :user_ids, :document, 
                  :document_cache, :remove_document, :is_selected

  has_paper_trail

  default_scope -> {order(year: :desc, month: :desc, articlestatus_id: :asc, authors: :asc) }
  #default_scope :order => 'is_selected DESC, articlestatus_id ASC, year DESC, month DESC, authors ASC'

  scope :in_year, lambda { |year| where('year = ?', year) }
  scope :accepted, -> { where(:articlestatus_id => 1) }
  scope :sent, -> { where(:articlestatus_id => 2) }
  scope :inprogress, -> { where(:articlestatus_id => 4) }
  scope :published, -> { where(:articlestatus_id => 3) }
  scope :unpublished, -> { where('articles.articlestatus_id != 3') }
  scope :verified, -> { where(:is_verified => true) }
  scope :selected, -> { where(:is_selected => true) }
  scope :current_year, -> { where(:year => (Date.today.year)) }
  scope :last_year, -> { where(:year => (Date.today.month.to_i <= 4 ? (Date.today.year - 1) : 2199)) }
  scope :unverified, -> { where("is_verified IS NULL OR is_verified = 'f'") }
  scope :user_id_eq, lambda { |user_id| joins(:user_articles).where(:user_articles => {:user_id => user_id}) }
  scope :journal_country_id_eq, lambda { |country_id| joins(:journal).where(:journal => {:country_id => country_id}) }
  scope :journal_country_id_not_eq, lambda { |country_id| joins(:journal).where("journals.country_id != ?", country_id) }


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

  # search_methods :user_id_eq, :user_id_not_eq, :adscription_id_eq

  def to_s
    i_f = journal.impact_factor(year)
    array = [authors, title, journal.name, normalized_date, normalized_vol_and_num, normalized_pages]
    unless i_f  =='n/a'
      array.insert(3, "Impact factor: #{i_f}")
    end
    if articlestatus_id != 3
      array.push("Status: #{articlestatus.name}")
    end
    array.compact.join(', ').sub(/;,/, ';')
  end

  def self.articles_by_impact_factor(year)
    intervals=[[0,2],[2,4],[4,6],[6,8],[8,10],[10,20],[20,30],[30,40],[40,1000000]]
    total = Article.where(:year=>year, :is_verified=>true).count
    result = Hash.new
    intervals.each do |interval|
      query = "SELECT distinct articles.id FROM articles
                JOIN journals ON articles.journal_id = journals.id
                JOIN impact_factors ON journals.id = impact_factors.journal_id
                WHERE articles.is_verified = 't' AND articles.year = ? AND impact_factors.year = articles.year
                      AND impact_factors.value > ? AND impact_factors.value <= ?", year, interval[0], interval[1]
      tot = find_by_sql(query).length
      unless tot==0
        if interval[0]==40 then
          result['mayor a 40']
        else
          result[interval[0].to_s+'-'+interval[1].to_s]=tot
        end
        total -= tot
      end
    end
    result['n/a']=total
    result
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

  def self.grouped_articles(adsc_year)
    adscriptions = UserAdscription.all_adscriptions
    res = Hash.new
    adscriptions.map { |adsc| res[adsc.name]=0 }
    query = "SELECT adscriptions.name, count(distinct articles.id) adsc_tot FROM articles
              JOIN user_articles ON articles.id = user_articles.article_id
              JOIN users ON users.id = user_articles.user_id
              JOIN user_adscription_records ON users.id = user_adscription_records.user_id
              JOIN adscriptions ON user_adscription_records.adscription_id = adscriptions.id
              WHERE articles.is_verified = 't' AND articles.year = ? AND articles.year = user_adscription_records.year
              GROUP BY adscriptions.name", adsc_year[:year]
    find_by_sql(query).map { |r| res[r.name] = r.adsc_tot }
    res
  end

  def self.repeated_grouped_articles(adsc_year)
    query = "SELECT distinct articles.id,users.id FROM articles
              JOIN user_articles ON articles.id = user_articles.article_id
              JOIN users ON users.id = user_articles.user_id
              JOIN user_adscriptions ON users.id = user_adscriptions.user_id
              JOIN adscriptions ON user_adscriptions.adscription_id = adscriptions.id
              WHERE articles.is_verified = 't' AND articles.year = ? and adscriptions.name = ?", adsc_year[:year], adsc_year[:adsc]
    find_by_sql(query)
  end

  def self.articles_mexican_journal(count_year)
    @cad = count_year[:country]=='Nacionales' ? '' : '!'
    query = "SELECT distinct articles.id FROM articles
              JOIN journals ON articles.journal_id = journals.id
              JOIN countries ON countries.id = journals.country_id
              WHERE articles.is_verified = 't' AND countries.id "+@cad+"= 484 AND articles.year = ?", count_year[:year]
    find_by_sql(query)
  end

  def tl_month
    @mes = {1=>'01',2=>'02',3=>'03',4=>'04',5=>'05',6=>'06',7=>'07',8=>'08',9=>'09',10=>'10',11=>'11',12=>'12'}
    @mes[month]
  end

  def tl_show_month
    @mes = {1=>'Jan',2=>'Feb',3=>'Mar',4=>'Apr',5=>'May',6=>'Jun',7=>'Jul',8=>'Aug',9=>'Sep',10=>'Oct',11=>'Nov',12=>'Dec'}
    @mes[month]
  end

  def as_json(options={})
    { :id=>id.to_s, :label=>title, :authors=>authors,
      :journal=>journal.name, :country=>journal.country_name, :year=>year.to_s,
      :date=>year.to_s+(if (tl_month.nil?) then '' else '-'+tl_month+'-01' end),
      :show_date=>(if (tl_show_month.nil?) then '' else tl_show_month end)+' '+year.to_s,
      :url=>(if (url.nil? or url=='') then '#' else url end)
    }
  end
end
