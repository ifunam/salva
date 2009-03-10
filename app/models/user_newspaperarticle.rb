class UserNewspaperarticle < ActiveRecord::Base
  validates_numericality_of :id, :newspaperarticle_id, :user_id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_inclusion_of :ismainauthor, :in=> [true, false]

  belongs_to :newspaperarticle
  named_scope :find_by_newspaperarticle_year, lambda { |y|  {:conditions => [ "date_part('year',newspaperarticles.newsdate::date) = ?", y ],  :include => [ { :newspaperarticle => :newspaper }]}}

  def as_text 
    # Fix It: Use internationalization features
    # as_text_line([newspaperarticle.authors, newspaperarticle.title, newspaperarticle.newspaper.name, newspaperarticle.newsdate.to_s(:long)])
    as_text_line([newspaperarticle.authors, newspaperarticle.title, newspaperarticle.newspaper.name, newspaperarticle.newsdate.to_s.split('-').reverse.join('/')])
  end
  
end
