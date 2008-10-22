class Article < ActiveRecord::Base
   validates_presence_of :title, :articlestatus_id, :year, :authors
   validates_numericality_of :id, :journal_id, :only_integer => true, :greater_than => 0, :allow_nil => true
   validates_numericality_of :articlestatus_id, :only_integer => true, :greater_than => 0
   validates_numericality_of :year, :greater_than => (Date.today.year - 100), :less_than_or_equal_to => (Date.today.year + 1), :only_integer => true
   validates_uniqueness_of :title, :scope => [:journal_id, :year]

  belongs_to :journal
  belongs_to :articlestatus

  has_many :user_articles
  has_many :users, :through => :user_articles
  named_scope :published_by_year, lambda { |y|  { :conditions => ['year = ?', y], :order => 'articles.year DESC, articles.month DESC, articles.authors ASC, articles.title ASC' } }
  
  def as_text
    [authors, title, journal.name, year, journal_issue, pages ].compact.collect { |v|
      s = (v.is_a? String) ? v.strip.gsub(/\n/,'').gsub(/\r/,'').strip.gsub(/\s{1}+/,' ').gsub(/^\"|\"$|^\“|\”$|^\'|\'$/,'').gsub(/ \./,'').sub(/( \,$)+/,'') : v.to_s
      s unless s.strip.empty?
    }.compact.join(', ').gsub(/( \,)/,',').gsub(/\,+/,',')
  end
  
  private
  def journal_issue
    if !vol.to_s.empty? and !num.to_s.empty?
      "#{vol.to_s.strip}(#{num.to_s.strip})"
    elsif !vol.nil?
      vol.to_s.strip
    elsif !num.nil?
      "(#{num.to_s.strip})"
    end
  end

end
