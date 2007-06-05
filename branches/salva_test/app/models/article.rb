class Article < ActiveRecord::Base
  validates_presence_of :title, :journal_id, :articlestatus_id, :year, :authors
  validates_numericality_of :journal_id, :articlestatus_id

  belongs_to :journal
  belongs_to :articlestatus

  has_many :user_articles
  has_many :users, :through => :user_articles
  
  def as_vancouver
    [self.authors, self.title, self.journal.name, journal_issue, self.pages].join(', ')
  end
  
  def journal_issue
    info = self.year.to_s + ";"
    if self.vol != nil and self.num != nil
      info << "#{self.vol}(#{self.num})"
    elsif self.vol != nil
      info << self.vol
    elsif self.num != nil
      info << "(#{self.num})"
    end
    info
  end
end
