class UserArticle < ActiveRecord::Base
  attr_accessible :article_id, :user_id

  validates_numericality_of :id,  :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :article_id, :user_id, :greater_than => 0, :only_integer => true, :allow_nil => true
  validates_inclusion_of :ismainauthor, :in => [true, false]
  # validates_uniqueness_of :article_id, :scope => [:user_id]
  attr_accessible :ismainauthor, :user_id, :article_id, :show_in_home_page

  belongs_to :article, :inverse_of => :user_articles
  belongs_to :user, :inverse_of => :user_articles

end
