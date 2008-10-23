class UserArticle < ActiveRecord::Base
  acts_as_dependent_mapper  :sequence => [ :article, [ :journal, [ :publisher ] ] ]

  validates_numericality_of :id,  :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :article_id, :user_id, :greater_than => 0, :only_integer => true, :allow_nil => true
  validates_inclusion_of :ismainauthor, :in => [true, false]
  validates_uniqueness_of :article_id, :scope => [:user_id]

  belongs_to :article, :include => [:articlestatus]
  belongs_to :user
end
