class UserArticle < ActiveRecord::Base
  validates_presence_of :article_id
  validates_numericality_of :id,  :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :article_id, :user_id, :greater_than => 0, :only_integer => true
  validates_inclusion_of :ismainauthor, :in => [true, false]
  validates_uniqueness_of :article_id, :scope => [:user_id]

  belongs_to :article
  belongs_to :user

end
