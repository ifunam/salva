class Article < ActiveRecord::Base
  validates_presence_of :title, :journal_id, :articlestatus_id, :year, :authors
  validates_numericality_of :id, :only_integer => true, :greater_than => 0, :allow_nil => true
  validates_numericality_of :journal_id, :articlestatus_id, :only_integer => true, :greater_than => 0
  validates_numericality_of :year, :greater_than => (Date.today.year - 100), :less_than_or_equal_to => (Date.today.year + 1), :only_integer => true
  validates_uniqueness_of :title, :scope => [:journal_id, :year]

  belongs_to :journal
  belongs_to :articlestatus

  has_many :user_articles
  has_many :users, :through => :user_articles

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
