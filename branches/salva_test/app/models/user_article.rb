class UserArticle < ActiveRecord::Base
  validates_presence_of :article_id, :user_id
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :article_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true

  validates_uniqueness_of :user_id, :article_id
 
  belongs_to :article
  belongs_to :user
end
